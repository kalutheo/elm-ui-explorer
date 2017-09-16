module Atom.Button.Index exposing (..)

import Html exposing (Html, text, button)
import Html.Attributes exposing (style, class)
import Atom.System exposing (colors)


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
        [ ( "backgroundColor", "#db7093" )
        , ( "color", colors.light )
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
        baseStyle ++ [ ( "backgroundColor", bgColor ), ( "color", colors.light ) ]


applySize isLarge baseStyle =
    let
        buttonWidth =
            if isLarge then
                sizes.largeWidth
            else
                sizes.tinyWidth
    in
        baseStyle ++ [ ( "width", (buttonWidth |> toString) ++ "em" ) ]


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
    button [ class "button is-white", model.buttonStyle ] [ text model.label ]


customButton : ButtonModel -> Html msg
customButton =
    viewButton << selectorButton
