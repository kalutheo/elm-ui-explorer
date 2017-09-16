module Atom.Toast.Stories exposing (..)

import Atom.Toast.Index exposing (..)
import UIExplorer exposing (renderStories)


states : List ( String, ToastModel )
states =
    [ ( "Success", { label = "Toast", isShown = True, severity = Success } )
    , ( "Warning", { label = "Toast", isShown = True, severity = Warning } )
    , ( "Error", { label = "Toast", isShown = True, severity = Error } )
    ]


viewStories config =
    renderStories config toast states
