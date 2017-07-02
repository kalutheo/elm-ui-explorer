module App exposing (..)

import StoryBook.Index exposing (storybook)
import Stories.PlayPause as PlayPause


main =
    storybook
        [ { id = "PlayPause"
          , description = "a simple playPause Button"
          , view = PlayPause.story
          }
        ]
