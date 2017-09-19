module Molecule.Menu.Stories exposing (..)

import Molecule.Menu.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view stories
