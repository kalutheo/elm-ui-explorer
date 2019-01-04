module Components.Header.View exposing (viewPrimary, viewSecondary)

import Components.Text.View as Text
import Element exposing (..)
import Element.Background as Background
import Theme.Color exposing (Color, color)
import Theme.Icons.Icon as Icon exposing (Size(..), icon)
import Theme.Typography exposing (typography)
import Utils exposing (toRgb)


type Appearance
    = Primary
    | Secondary


type alias Theme =
    { background : Color
    , color : Color
    }


viewPrimary =
    view Primary


viewSecondary =
    view Secondary


getTheme : Appearance -> Theme
getTheme appearance =
    case appearance of
        Primary ->
            { background = color.neutral.white
            , color = color.brand.primary
            }

        Secondary ->
            { background = color.brand.primary
            , color = color.neutral.white
            }


view : Appearance -> Element msg
view appearance =
    let
        theme =
            getTheme appearance
    in
    Element.row
        [ Background.color <| toRgb theme.background
        , width fill
        , padding 16
        , spacing 64
        ]
        [ Element.el []
            (Element.html <|
                Icon.view theme.color icon.logo S
            )
        , Text.text "08.75.57.43.32" typography.paragraph theme.color
        ]
