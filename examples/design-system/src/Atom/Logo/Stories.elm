module Atom.Logo.Stories exposing (..)

import Atom.Logo.Index exposing (view)
import UIExplorer exposing (renderStories)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view states
