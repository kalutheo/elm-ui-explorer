module App exposing (..)

import UIExplorer exposing (app, fromUIList, createUI)
import Stories.PlayPause as PlayPause
import Stories.Controls as Controls
import Stories.TrackList as TrackList


main =
    app
        (fromUIList
            [ createUI
                "PlayPause"
                PlayPause.viewStories
            , createUI
                "Controls"
                Controls.viewStories
            , createUI
                "TrackList"
                TrackList.viewStories
            ]
        )
