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
        [ validEmail1
        , Html.br [] []
        , validEmail2
        ]


validEmail1 : Html msg
validEmail1 =
    let
        emailResult : Result String Email
        emailResult =
            Email.fromString "hello@example.com"
    in
    case emailResult of
        Ok email ->
            Html.text ("Valid email: " ++ email)

        Err error ->
            Html.text error


validEmail2 : Html msg
validEmail2 =
    let
        emailResult : Result String Email
        emailResult =
            Ok "hello"
    in
    case emailResult of
        Ok email ->
            Html.text ("Valid email: " ++ email)

        Err error ->
            Html.text error
