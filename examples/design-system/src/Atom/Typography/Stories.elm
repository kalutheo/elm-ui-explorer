module Atom.Typography.Stories exposing (..)

import Atom.Typography.Index exposing (Model, view)
import UIExplorer exposing (renderStories)


stories : List ( String, Model )
stories =
    [ ( "Default", { label = "The quick brown fox jumps over the lazy dog" } ) ]


viewStories =
    renderStories view stories


viewSnapshot =
    UIExplorer.viewSnapshot stories view
