module Molecule.NavBar.Story exposing (..)

import Molecule.NavBar.Index exposing (view)
import StoryBook exposing (renderStory)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
