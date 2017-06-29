module Atom.Collapsible exposing (..)

import Html.Attributes exposing (class)
import Html exposing (Html, text, button)
import StoryBook.Update exposing (Msg)
import Elegant exposing (..)


-- Collapsible --


type alias CollapsibleModel a =
    { label : String, isOpen : Bool, content : Html a }


type alias CollapsibleViewModel a =
    { label : String, isOpen : Bool, icon : String, content : Html a }


selectorCollapsible : CollapsibleModel a -> CollapsibleViewModel a
selectorCollapsible model =
    let
        icon =
            case model.isOpen of
                True ->
                    "[+]"

                False ->
                    "[-]"
    in
        { icon = icon
        , content = model.content
        , label = model.label
        , isOpen = model.isOpen
        }


viewCollapsible : CollapsibleViewModel a -> Html a
viewCollapsible model =
    div []
        [ header []
            [ i []
                [ text model.icon ]
            , span
                []
                [ text model.label ]
            ]
        , section [] [ model.content ]
        ]


collapsible : CollapsibleModel a -> Html a
collapsible =
    viewCollapsible << selectorCollapsible
