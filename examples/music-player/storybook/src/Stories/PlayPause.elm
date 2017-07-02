module Stories.PlayPause exposing (..)

import Html
import StoryBook.View exposing (renderStory)
import View exposing (playPauseView)
import Model exposing (Model)
import Storybook.Msg as Storybook


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
    renderStory selectedStateId (Html.map Storybook.Msg playPauseView) stories
