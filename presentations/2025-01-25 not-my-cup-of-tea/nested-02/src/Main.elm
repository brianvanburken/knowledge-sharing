module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Events


type alias Model =
    { count : Int
    , subModel : Decrement.Model Msg
    }


init : Model
init =
    { count = 0
    , subModel = Decrement.init
    }


type Msg
    = Increment
    | Decrement
    | SubMsg Decrement.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement amount ->
            { model | count = model.count - amount }

        SubMsg subMsg ->
            { model | subModel = Decrement.update subMsg model.subModel }


view : Model -> Html Msg
view { count, subModel, subModel2 } =
    Html.div []
        [ Html.div [] [ Html.text (String.fromInt count) ]
        , Html.button [ Html.Events.onClick Increment ] [ Html.text "+1" ]
        , Decrement.view subModel |> Html.map SubMsg
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
