module Length exposing (add, convert, kilometersToMilesRate, milesToKilometerRate)

{-| Length module

For safely converting between units of length.

-}

-- Part 1: Define the phantom type here
-- Part 2: Define functions


{-| Takes two lengths from the same unit and adds them together.
-}
add : number -> number -> number
add x y =
    x + y



--- Part 2


milesToKilometerRate : Float
milesToKilometerRate =
    1.61


kilometersToMilesRate : Float
kilometersToMilesRate =
    0.62


{-| Converts a length from one unit to another.
-}
convert : number -> number -> number
convert rate length =
    length * rate
