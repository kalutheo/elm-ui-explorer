module Atom.Typography.Story exposing (..)

import Atom.Typography.Index exposing (view, Model)
import StoryBook exposing (renderStory)


stories : List ( String, Model )
stories =
    [ ( "Default", { label = "The quick brown fox jumps over the lazy dog" } ) ]


story config =
    renderStory config view stories
