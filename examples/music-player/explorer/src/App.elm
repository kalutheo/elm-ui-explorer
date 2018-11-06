module App exposing (main)

import Stories.Controls as Controls
import Stories.PlayPause as PlayPause
import Stories.TrackList as TrackList
import UIExplorer exposing (app, createUI, fromUIList)


main : Program Never UIExplorer.Model UIExplorer.Msg
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
