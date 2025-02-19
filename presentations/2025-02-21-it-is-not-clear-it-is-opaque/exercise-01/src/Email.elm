module Email exposing (..)


type alias Email =
    String


fromString : String -> Result String Email
fromString email =
    if String.contains "@" email then
        Ok email

    else
        Err "This is not a valid email address."
