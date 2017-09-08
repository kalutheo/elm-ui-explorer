module Molecule.Card.Index exposing (..)

import Html exposing (div, figure, img, p, text, a, br, small)
import Html.Attributes exposing (class, alt, src)


view model =
    div
        [ class "card" ]
        [ div
            [ class "card-content" ]
            [ div
                [ class "media" ]
                [ div
                    [ class "media-left" ]
                    [ figure
                        [ class "image is-48x48" ]
                        [ img
                            [ src "http://bulma.io/images/placeholders/96x96.png", alt "Image" ]
                            []
                        ]
                    ]
                , div
                    [ class "media-content" ]
                    [ p
                        [ class "title is-4" ]
                        [ text "John Smith" ]
                    , p
                        [ class "subtitle is-6" ]
                        [ text "@johnsmith" ]
                    ]
                ]
            , div
                [ class "content" ]
                [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n      Phasellus nec iaculis mauris."
                , a
                    []
                    [ text "@bulmaio" ]
                , a
                    []
                    [ text "#css" ]
                , a
                    []
                    [ text "#responsive" ]
                , br
                    []
                    []
                , small
                    []
                    [ text "11:09 PM - 1 Jan 2016" ]
                ]
            ]
        ]
