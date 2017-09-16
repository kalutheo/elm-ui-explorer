module Page.Home.Index exposing (..)

import Html exposing (nav, div, button, img, a, span, text)
import Html.Attributes exposing (style, id, class, href, src, attribute, alt, height, width)
import Organism.Header.Index as Header
import Organism.CardGrid.Index as CardGrid
import Organism.Hero.Index as Hero


view model =
    div [ style [ ( "backgroundColor", "#CCC" ) ] ]
        [ Header.view {}
        , div []
            [ Hero.view
                { title = "Welcome to the home"
                , subtitle = "A place to manage your contacts"
                , linkLabel = "Dicover now >>"
                }
            ]
        ]
