module Atom.Toast.Story exposing (..)

import Atom.Toast.Index exposing (..)
import StoryBook.View exposing (renderStory)
import Util exposing (..)


stories : List ( String, ToastModel )
stories =
    [ ( "Success", { label = "Toast", isShown = True, severity = Success } )
    , ( "Warning", { label = "Toast", isShown = True, severity = Warning } )
    , ( "Error", { label = "Toast", isShown = True, severity = Error } )
    ]


story selectedStateId =
    renderStory selectedStateId toast stories emptyMsg emptyDiv
