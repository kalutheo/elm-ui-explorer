module Atom.Logo.Story exposing (..)

import Atom.Logo.Index exposing (view)
import UIExplorer exposing (renderStory)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
