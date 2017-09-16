module Molecule.Menu.Stories exposing (..)

import Molecule.Menu.Index exposing (view)
import UIExplorer exposing (renderStories)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view states
