module StoryBook.Update exposing (..)

import StoryBook.Model exposing (StoryId)


type Msg
    = Noop
    | SelectStory StoryId
