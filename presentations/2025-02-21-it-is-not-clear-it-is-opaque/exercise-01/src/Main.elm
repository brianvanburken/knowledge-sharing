module Main exposing (main)

import Browser
import Email exposing (Email)
import Html exposing (Html)


main : Program () {} ()
main =
    Browser.sandbox { init = {}, update = \_ _ -> {}, view = view }


view : {} -> Html ()
view _ =
    Html.div
        []
        [ Email.fromString "hello@example.com"
            |> viewEmail
        , Html.br [] []
        , Email.fromString "bad"
            |> viewEmail
        ]


viewEmail : Result String Email -> Html msg
viewEmail emailResult =
    case emailResult of
        Ok email ->
            Html.text ("Valid email: " ++ email)

        Err error ->
            Html.text ("Invalid email: " ++ error)
