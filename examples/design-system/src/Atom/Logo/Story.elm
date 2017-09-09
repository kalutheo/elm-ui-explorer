module Atom.Logo.Story exposing (..)

import Atom.Logo.Index exposing (view)
import StoryBook exposing (renderStory)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
