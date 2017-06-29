module StoryBook.Update exposing (..)

import StoryBook.Model exposing (Story)


type Msg
    = Noop
    | SelectStory Story
