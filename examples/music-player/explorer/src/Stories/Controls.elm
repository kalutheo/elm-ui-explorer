module Stories.Controls exposing (..)

import Html exposing (Html, div, ul, text)
import Html.Attributes exposing (class)
import UIExplorer exposing (renderStories)
import View exposing (controlsView)
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


story selectedStateId =
    renderStories selectedStateId controlsView stories
