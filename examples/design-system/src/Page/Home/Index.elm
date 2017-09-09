module Page.Home.Index exposing (..)

import Html exposing (nav, div, button, img, a, span, text)
import Html.Attributes exposing (id, class, href, src, attribute, alt, height, width)
import Organism.Header.Index as Header
import Organism.CardGrid.Index as CardGrid


view model =
    div []
        [ Header.view {}
        , div [] [ text "Home Page..." ]
        ]
