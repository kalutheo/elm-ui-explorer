module Molecule.Menu.Index exposing (..)

import Html exposing (nav, div, button, img, a, span, text)
import Html.Attributes exposing (id, class, href, src, attribute, alt, height, width)
import Atom.Logo.Index as Logo


view model =
    div
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
