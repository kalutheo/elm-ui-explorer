module Atom.Button.Story exposing (..)

import UIExplorer exposing (renderStory)
import Atom.Button.Index exposing (customButton, ButtonModel)


states : List ( String, ButtonModel )
states =
    [ ( "LargePrimary", { label = "Primary", isLarge = True, isPrimary = True } )
    , ( "TinyPrimary", { label = "Primary", isLarge = False, isPrimary = True } )
    , ( "LargeSecondary", { label = "Secondary", isLarge = True, isPrimary = False } )
    , ( "TinySecondary", { label = "Secondary", isLarge = False, isPrimary = False } )
    ]


story config =
    renderStory config customButton states
