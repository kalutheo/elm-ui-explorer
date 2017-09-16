module Organism.Hero.Index exposing (..)

import Html exposing (Html, a, div, text, section, h1, h2)
import Html.Attributes exposing (class, style)


type alias Model =
    { title : String
    , subtitle : String
    , linkLabel : String
    }


view : Model -> Html msg
view model =
    section
        [ class "hero is-primary is-medium" ]
        [ div
            [ class "hero-body" ]
            [ div
                [ class "container" ]
                [ h1
                    [ class "title" ]
                    [ text model.title ]
                , h2
                    [ class "subtitle" ]
                    [ text model.subtitle ]
                ]
            , div [ style [ ( "marginTop", "1em" ) ] ]
                [ a
                    [ class "button is-primary is-inverted" ]
                    [ text model.linkLabel ]
                ]
            ]
        ]
