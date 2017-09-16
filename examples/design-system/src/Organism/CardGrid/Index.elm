module Organism.CardGrid.Index exposing (..)

import Html exposing (div, text, p, article)
import Html.Attributes exposing (style, class)
import Molecule.Card.Index as Card


view model =
    div [ style [ ( "padding", "3em" ) ] ]
        [ div
            [ class "tile is-ancestor" ]
            [ div
                [ class "tile is-parent" ]
                [ Card.view {} ]
            , div
                [ class "tile is-parent" ]
                [ Card.view {} ]
            ]
        , div
            [ class "tile is-ancestor" ]
            [ div
                [ class "tile is-parent" ]
                [ Card.view {} ]
            , div
                [ class "tile is-parent" ]
                [ Card.view {} ]
            ]
        ]
