module Atom.Toast.Stories exposing (..)

import Atom.Toast.Index exposing (..)
import UIExplorer exposing (renderStories)


stories : List ( String, ToastModel )
stories =
    [ ( "Success", { label = "Toast", isShown = True, severity = Success } )
    , ( "Warning", { label = "Toast", isShown = True, severity = Warning } )
    , ( "Error", { label = "Toast", isShown = True, severity = Error } )
    ]


viewStories config =
    renderStories config toast stories
