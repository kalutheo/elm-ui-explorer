module Atom.Toast.Story exposing (..)

import Atom.Toast.Index exposing (..)
import StoryBook exposing (renderStory)


stories : List ( String, ToastModel )
stories =
    [ ( "Success", { label = "Toast", isShown = True, severity = Success } )
    , ( "Warning", { label = "Toast", isShown = True, severity = Warning } )
    , ( "Error", { label = "Toast", isShown = True, severity = Error } )
    ]


story selectedStateId =
    renderStory selectedStateId toast stories
