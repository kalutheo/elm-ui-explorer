module Atom.Logo.Stories exposing (..)

import Atom.Logo.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view stories
