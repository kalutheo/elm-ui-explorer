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
                    PlayPause.viewStories
                , createUI
                    "Controls"
                    Controls.viewStories
                , createUI
                    "TrackList"
                    TrackList.viewStories
                ]
        )
