module App exposing (..)

import StoryBook.Index exposing (storybook)
import Stories.PlayPause as PlayPause
import Stories.Controls as Controls
import Stories.TrackList as TrackList


main =
    storybook
        [ { id = "PlayPause"
          , description = "a simple playPause Button"
          , view = PlayPause.story
          }
        , { id = "Controls"
          , description = "music player Controls"
          , view = Controls.story
          }
        , { id = "TrackList"
          , description = "List of tracks"
          , view = TrackList.story
          }
        ]
