module Main exposing (main)

import Browser
import Html exposing (Html)
import SortedList


main : Program () {} ()
main =
    Browser.sandbox { init = {}, update = \_ _ -> {}, view = view }


view : {} -> Html ()
view _ =
    Html.div []
        [ SortedList.config [ "a", "b", "c" ] SortedList.Descending
            |> (\config ->
                    { config | direction = SortedList.Ascending }
               )
            |> SortedList.render
        ]
