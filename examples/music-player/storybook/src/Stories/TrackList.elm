module Stories.TrackList exposing (..)

import Html exposing (Html, div, ul, text)
import StoryBook exposing (renderStory)
import View exposing (trackListView)
import Model exposing (Model, mockAlbum)


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
    renderStory selectedStateId trackListView stories
