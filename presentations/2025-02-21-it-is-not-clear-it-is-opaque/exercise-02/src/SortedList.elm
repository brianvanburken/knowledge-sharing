module SortedList exposing (Config, Direction(..), config, render)

import Html exposing (Html)


type Direction
    = Ascending
    | Descending


type alias Config =
    { list : List String
    , direction : Direction
    }


config : List String -> Direction -> Config
config list direction =
    { list =
        case direction of
            Ascending ->
                List.sort list

            Descending ->
                List.sort list |> List.reverse
    , direction = direction
    }


render : Config -> Html msg
render model =
    Html.div []
        [ case model.direction of
            Ascending ->
                Html.text "Ascending list:"

            Descending ->
                Html.text "Descending list:"
        , Html.ul [] (List.map (\item -> Html.li [] [ Html.text item ]) model.list)
        ]
