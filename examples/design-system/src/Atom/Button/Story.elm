module Atom.Button.Story exposing (..)

import StoryBook.View exposing (renderStory)
import Atom.Button.Index exposing (customButton, ButtonModel)
import Util exposing (..)


stories : List ( String, ButtonModel )
stories =
    [ ( "LargePrimary", { label = "Primary", isLarge = True, isPrimary = True } )
    , ( "TinyPrimary", { label = "Primary", isLarge = False, isPrimary = True } )
    , ( "LargeSecondary", { label = "Secondary", isLarge = True, isPrimary = False } )
    , ( "TinySecondary", { label = "Secondary", isLarge = False, isPrimary = False } )
    ]


story selectedStateId =
    renderStory selectedStateId customButton stories emptyMsg emptyDiv
