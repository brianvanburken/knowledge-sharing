module Email exposing (..)


type alias Email =
    String


fromString : String -> Result String Email
fromString email =
    Ok email
