module App exposing (..)

import UIExplorer exposing (app)
import Stories.PlayPause as PlayPause
import Stories.Controls as Controls
import Stories.TrackList as TrackList


main =
    app
        [ ( "Default"
          , [ { id = "PlayPause"
              , description = "A simple play/pause button"
              , viewStories = PlayPause.story
              }
            , { id = "Controls"
              , description = "Music player controls"
              , viewStories = Controls.story
              }
            , { id = "TrackList"
              , description = "List of tracks"
              , viewStories = TrackList.story
              }
            ]
          )
        ]
