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
              , viewStories = PlayPause.viewStories
              }
            , { id = "Controls"
              , description = "Music player controls"
              , viewStories = Controls.viewStories
              }
            , { id = "TrackList"
              , description = "List of tracks"
              , viewStories = TrackList.viewStories
              }
            ]
          )
        ]
