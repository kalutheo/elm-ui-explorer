module StoryBook.ModelStory exposing (..)

import Html exposing (Html)
import Storybook.Message exposing (Msg)


type alias Story =
    { id : StoryId
    , description : String
    , view : Html Msg
    }
