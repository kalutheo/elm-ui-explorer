module Atom.Typography.Stories exposing (..)

import Atom.Typography.Index exposing (view, Model)
import UIExplorer exposing (renderStories)


stories : List ( String, Model )
stories =
    [ ( "Default", { label = "The quick brown fox jumps over the lazy dog" } ) ]


viewStories =
    renderStories view stories
