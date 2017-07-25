module Stories.TrackList exposing (..)

import Html exposing (Html, div, ul, text)
import StoryBook.View exposing (renderStory)
import View exposing (trackListView)
import Model exposing (Model, mockAlbum)
import Storybook.Msg exposing (..)


playlist =
    mockAlbum.playlist
        |> List.take 1


album =
    { mockAlbum | playlist = playlist }


defaultState =
    { album = album
    , isPlaying = True
    , selectedTrack = Nothing
    }


stories : List ( String, Model )
stories =
    [ ( "Default", defaultState )
    , ( "Selected", { defaultState | selectedTrack = List.head playlist } )
    ]


wrapper children =
    div [] [ children ]


story selectedStateId =
    renderStory selectedStateId trackListView stories (\_ -> Noop) wrapper
