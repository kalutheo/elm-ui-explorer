module Atom.Button.Story exposing (..)

import StoryBook exposing (renderStory)
import Atom.Button.Index exposing (customButton, ButtonModel)


stories : List ( String, ButtonModel )
stories =
    [ ( "Large", { label = "Large", isLarge = True } )
    , ( "Tiny", { label = "Tiny", isLarge = False } )
    ]


story selectedStateId =
    renderStory selectedStateId customButton stories
