module Atom.Collapsible.Story exposing (..)

import Html exposing (Html, div)
import Atom.Collapsible.Index exposing (collapsible, CollapsibleModel)
import StoryBook.View exposing (renderStory)


dummyContent : Html msg
dummyContent =
    div [] []


stories : List ( String, CollapsibleModel msg )
stories =
    [ ( "isOpen", { label = "Hello", isOpen = True, content = dummyContent } )
    , ( "isClosed", { label = "Hello", isOpen = False, content = dummyContent } )
    ]


story selectedStateId =
    renderStory selectedStateId collapsible stories
