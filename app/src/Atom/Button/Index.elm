module Atom.Button.Index exposing (..)

import Html exposing (Html, text, button)
import Elegant exposing (..)
import Atom.System exposing (..)


type alias ButtonModel =
    { label : String, isLarge : Bool }


type alias ButtonViewModel msg =
    { label : String
    , isLoading : Bool
    , buttonStyle : Html.Attribute msg
    }


sizes =
    { largeWidth = 14
    , tinyWidth = 10
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


selectorButton : ButtonModel -> ButtonViewModel msg
selectorButton model =
    let
        buttonWidth =
            if model.isLarge then
                sizes.largeWidth
            else
                sizes.tinyWidth

        buttonStyle =
            style (List.append styles.base [ width (Em buttonWidth) ])
    in
        { label = model.label, isLoading = False, buttonStyle = buttonStyle }


viewButton : ButtonViewModel msg -> Html msg
viewButton model =
    button [ model.buttonStyle ] [ text model.label ]


customButton : ButtonModel -> Html msg
customButton =
    viewButton << selectorButton
