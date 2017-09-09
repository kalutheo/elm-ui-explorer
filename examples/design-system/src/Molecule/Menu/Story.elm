module Molecule.Menu.Story exposing (..)

import Molecule.Menu.Index exposing (view)
import StoryBook exposing (renderStory)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
