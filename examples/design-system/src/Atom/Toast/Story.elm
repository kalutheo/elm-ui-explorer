module Atom.Toast.Story exposing (..)

import Atom.Toast.Index exposing (..)
import StoryBook exposing (renderStory)


states : List ( String, ToastModel )
states =
    [ ( "Success", { label = "Toast", isShown = True, severity = Success } )
    , ( "Warning", { label = "Toast", isShown = True, severity = Warning } )
    , ( "Error", { label = "Toast", isShown = True, severity = Error } )
    ]


story config =
    renderStory config toast states
