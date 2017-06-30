module StoryBook.ModelStory exposing (..)

import Html exposing (Html)
import StoryBook.Update exposing (Msg)


type alias Story =
    { id : StoryId
    , description : String
    , view : Html Msg
    }
