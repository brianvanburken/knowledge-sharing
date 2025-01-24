module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Events


type alias Model =
    { count : Int
    }


init : Model
init =
    { count = 0
    }


type Msg
    = Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div [] [ Html.text (String.fromInt model.count) ]
        , Html.button [ Html.Events.onClick Increment ] [ Html.text "+1" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
