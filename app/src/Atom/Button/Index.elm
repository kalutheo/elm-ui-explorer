module Atom.Button.Index exposing (..)

import Html exposing (Html, text, button)
import Storybook.Msg exposing (Msg)
import Elegant exposing (..)
import Atom.System exposing (..)


type alias ButtonModel =
    { label : String, isLarge : Bool }


type alias ButtonViewModel =
    { label : String
    , isLoading : Bool
    , buttonStyle : Html.Attribute Msg
    }


styles =
    { base =
        [ backgroundColor colors.primary
        , textColor colors.light
        , borderRadius 10
        , margin medium
        , borderWidth 0
        , padding (Em 1)
        ]
    }


selectorButton : ButtonModel -> ButtonViewModel
selectorButton model =
    let
        label =
            ">>" ++ model.label

        buttonWidth =
            if model.isLarge then
                14
            else
                10

        buttonStyle =
            style (List.append styles.base [ width (Em buttonWidth) ])
    in
        { label = label, isLoading = False, buttonStyle = buttonStyle }


viewButton : ButtonViewModel -> Html Msg
viewButton model =
    button [ model.buttonStyle ] [ text model.label ]


customButton : ButtonModel -> Html Msg
customButton =
    viewButton << selectorButton
