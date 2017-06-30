module StoryBook.Model exposing (..)

import Html exposing (Html)


type alias Story msg =
    { id : StoryId
    , description : String
    , view : Html msg
    }


type alias Stories msg =
    List (Story msg)


type alias Model msg =
    { stories : Stories msg
    , selectedStoryId : StoryId
    }


type StoryId
    = CustomButton
    | Toast
    | None
