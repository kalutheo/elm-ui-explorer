module Molecule.Menu.Story exposing (..)

import Molecule.Menu.Index exposing (view)
import UIExplorer exposing (renderStory)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
