module Organism.Header.Index exposing (..)

import Html exposing (nav, div, button, img, a, span, text)
import Html.Attributes exposing (id, class, href, src, attribute, alt, height, width)
import Atom.Logo.Index as Logo
import Molecule.Menu.Index as Menu


view model =
    nav
        [ class "navbar"
        , attribute "role" "navigation"
        , attribute "aria-label" "main navigation"
        ]
        [ div
            [ class "navbar-brand" ]
            [ a
                [ class "navbar-item", href "" ]
                [ Logo.view {}
                ]
            ]
        , Menu.view {}
        ]
