module Decrement exposing (Model, Msg, init, update, view)

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
    = Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div [] [ Html.text (String.fromInt model.count) ]
        , Html.button [ Html.Events.onClick (Decrement) ] [ Html.text "-1" ]
        , Html.button [] [ Html.text "-1 (parent)" ]
        ]
