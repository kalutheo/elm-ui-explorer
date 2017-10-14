module App exposing (..)

import UIExplorer exposing (app, addUICategory, emptyUICategories, createUI)
import Stories.PlayPause as PlayPause
import Stories.Controls as Controls
import Stories.TrackList as TrackList


main =
    app
        (emptyUICategories
            |> addUICategory
                "Default"
                [ createUI
                    "PlayPause"
                    "A simple play/pause button"
                    PlayPause.viewStories
                , createUI
                    "Controls"
                    "Music player controls"
                    Controls.viewStories
                , createUI
                    "TrackList"
                    "List of tracks"
                    TrackList.viewStories
                ]
        )
