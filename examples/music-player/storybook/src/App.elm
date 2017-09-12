module App exposing (..)

import StoryBook exposing (storybook)
import Stories.PlayPause as PlayPause
import Stories.Controls as Controls
import Stories.TrackList as TrackList


main =
    storybook
        [ ( "Default"
          , [ { id = "PlayPause"
              , description = "A simple play/pause button"
              , view = PlayPause.story
              }
            , { id = "Controls"
              , description = "Music player controls"
              , view = Controls.story
              }
            , { id = "TrackList"
              , description = "List of tracks"
              , view = TrackList.story
              }
            ]
          )
        ]
