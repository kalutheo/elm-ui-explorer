module Molecule.Card.Stories exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
import Molecule.Card.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


card model =
    div [ style [ ( "width", "400px" ) ] ] [ view model ]


viewStories =
    renderStories card stories


viewSnapshot =
    UIExplorer.viewSnapshot stories view
