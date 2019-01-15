module Components.Header.ElmjutsuDumMyM0DuL3 exposing (..)
-- exposing (viewPrimary, viewSecondary)

import Components.Text.View as Text
import Element exposing (..)
import Element.Background as Background
import Theme.Color exposing (Color, color)
import Theme.Icons.Icon as Icon exposing (Size(..), icon)
import Theme.Spacing as Spacing
import Theme.Typography exposing (typography)
import Utils exposing (toRgb)


type Appearance
    = Primary
    | Secondary


type alias Theme =
    { background : Color
    , color : Color
    , secondColor : Color
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
            , secondColor = color.neutral.greyDarker
            }

        Secondary ->
            { background = color.brand.primary
            , color = color.neutral.white
            , secondColor = color.neutral.white
            }


text theme =
    Text.text typography.paragraph theme.color


textSecondary theme =
    Text.text typography.paragraph theme.secondColor


view : Appearance -> Element msg
view appearance =
    let
        theme =
            getTheme appearance
    in
    Element.row
        [ Background.color <| toRgb theme.background
        , width fill
        , padding Spacing.medium.value
        , spacing Spacing.large.value
        ]
        [ Element.row
            [ spacing Spacing.large.value ]
            [ Element.el []
                (Element.html <|
                    Icon.view theme.color icon.logo M
                )
            ]
        , Element.row [ width fill, spacing Spacing.medium.value ]
            [ Element.row [ spacing Spacing.small.value, alignRight ]
                [ Element.el [] (Text.text typography.small theme.color "MENU")
                , Element.el []
                    (Element.html <|
                        Icon.view theme.color icon.menu XS
                    )
                ]
            ]
        ]
