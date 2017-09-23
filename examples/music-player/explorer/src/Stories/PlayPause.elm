module Stories.PlayPause exposing (..)

import Html exposing (Html, div, ul, text)
import Html.Attributes exposing (class)
import UIExplorer exposing (renderStories)
import View exposing (playPauseView)
import Model exposing (Model)


album =
    { cover = "test"
    , title = "test"
    , playlist = []
    }


defaultState =
    { album = album
    , isPlaying = True
    , selectedTrack = Nothing
    }


stories : List ( String, Model )
stories =
    [ ( "Playing", defaultState )
    , ( "Stopped", { defaultState | isPlaying = False } )
    ]


wrapper children =
    div [] [ children ]


viewStories config =
    renderStories config playPauseView stories
