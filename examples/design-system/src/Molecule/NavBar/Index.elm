module Molecule.NavBar.Index exposing (..)

import Html exposing (nav, div, button, img, a, span, text)
import Html.Attributes exposing (id, class, href, src, attribute, alt, height, width)
import Atom.Logo.Index as Logo


view model =
    nav
        [ class "navbar"
        , attribute "role" "navigation"
        , attribute "aria-label" "main navigation"
        ]
        [ div
            [ class "navbar-brand" ]
            [ a
                [ class "navbar-item" ]
                [ Logo.view {}
                ]
            , button
                [ class "button navbar-burger" ]
                [ span
                    []
                    []
                , span
                    []
                    []
                , span
                    []
                    []
                ]
            ]
        , div
            [ id "navMenubd-example", class "navbar-menu" ]
            [ a
                [ class "navbar-item " ]
                [ span
                    []
                    [ text "Home" ]
                ]
            , a
                [ class "navbar-item " ]
                [ span
                    []
                    [ text "About" ]
                ]
            ]
        ]
