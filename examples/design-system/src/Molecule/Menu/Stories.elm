module Molecule.Menu.Stories exposing (..)

import Molecule.Menu.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories =
    renderStories view stories
