module Main exposing (main)

import Browser
import LindaDrawer
import Html exposing (Html)


main : Program () {} ()
main =
    Browser.sandbox { init = {}, update = \_ _ -> {}, view = view }


view : {} -> Html ()
view _ =
    let
        {-| Initialize the drawer here -}
    in
    Html.div []
        [ {-| Configure the drawer here -}
        ]
