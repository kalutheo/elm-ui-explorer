module Atom.Button.Index exposing (..)

import Html exposing (Html, text, button)
import Elegant exposing (..)
import Atom.System exposing (..)


type alias ButtonModel =
    { label : String, isLarge : Bool, isPrimary : Bool }


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
        , fontSize (Px 15)
        , borderRadius 10
        , margin medium
        , borderWidth 0
        , padding (Em 1)
        ]
    }


applyColor isPrimary baseStyle =
    let
        bgColor =
            if isPrimary then
                colors.primary
            else
                colors.secondary
    in
        baseStyle ++ [ backgroundColor bgColor ]


applySize isLarge baseStyle =
    let
        buttonWidth =
            if isLarge then
                sizes.largeWidth
            else
                sizes.tinyWidth
    in
        baseStyle ++ [ width (Em buttonWidth) ]


selectorButton : ButtonModel -> ButtonViewModel msg
selectorButton model =
    { label = model.label
    , isLoading = False
    , buttonStyle =
        style
            (styles.base
                |> applyColor model.isPrimary
                |> applySize model.isLarge
            )
    }


viewButton : ButtonViewModel msg -> Html msg
viewButton model =
    button [ model.buttonStyle ] [ text model.label ]


customButton : ButtonModel -> Html msg
customButton =
    viewButton << selectorButton
