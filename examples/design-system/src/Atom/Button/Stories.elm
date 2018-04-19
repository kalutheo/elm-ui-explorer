module Atom.Button.Stories exposing (..)

import Atom.Button.Index exposing (ButtonModel, customButton)
import UIExplorer exposing (renderStories)


stories : List ( String, ButtonModel )
stories =
    [ ( "LargePrimary", { label = "Primary", isLarge = True, isPrimary = True } )
    , ( "TinyPrimary", { label = "Primary", isLarge = False, isPrimary = True } )
    , ( "LargeSecondary", { label = "Secondary", isLarge = True, isPrimary = False } )
    , ( "TinySecondary", { label = "Secondary", isLarge = False, isPrimary = False } )
    ]


viewStories =
    renderStories customButton stories


viewSnapshot =
    UIExplorer.viewSnapshot stories customButton
