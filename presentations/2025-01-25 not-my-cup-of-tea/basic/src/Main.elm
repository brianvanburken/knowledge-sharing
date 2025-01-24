module Main exposing (main)

import Browser exposing (Document)
import Html exposing (Html)
import Html.Events


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { count : Int
    }


init : Model
init =
    { count = 0
    }


type Msg
    = Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view { count } =
    Html.div []
        [ Html.div [] [ Html.text (String.fromInt count) ]
        , Html.button [ Html.Events.onClick Increment ] [ Html.text "+1" ]
        ]
