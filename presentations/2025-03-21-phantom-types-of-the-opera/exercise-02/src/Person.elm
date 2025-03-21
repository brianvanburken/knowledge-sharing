module Person exposing (Person, build, init, setAge, setName)


type alias PersonBuilder =
    { name : Maybe String
    , age : Maybe Int
    }


type alias Person =
    { name : String
    , age : Int
    }


init : PersonBuilder
init =
    { name = Nothing
    , age = Nothing
    }


setName : String -> PersonBuilder -> PersonBuilder
setName newName person =
    { person | name = Just newName }


setAge : Int -> PersonBuilder -> PersonBuilder
setAge newAge person =
    { person | age = Just newAge }



-- Lets make sure that you've filled in both name and age to complete the person


build : PersonBuilder -> Person
build person =
    { name = Maybe.withDefault "" person.name
    , age = Maybe.withDefault 0 person.age
    }
