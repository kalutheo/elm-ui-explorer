module Button exposing
    ( Config
    , Size(..)
    , Kind(..)
    , Appearance(..)
    , defaultButtonConfig
    , view
    )

{-|


# Button

The Button should be used to trigger user actions.
Some examples of interactions:

  - Submit a form
  - Cancel an order
  - Toggle a menu visibility
  - Play a media

```elm
import Button exposing (..)
Button.view "Submit" defaultButtonConfig ()
```


## Links:

  - [UX Planet - Basic rules for button](https://uxplanet.org/7-basic-rules-for-button-design-63dcdf5676b4)

@docs Config
@docs Size
@docs Kind
@docs Appearance

@docs defaultButtonConfig
@docs view

-}

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)


{-| Option to customize the Button
-}
type alias Config =
    { appearance : Appearance
    , size : Size
    , kind : Kind
    , class : String
    , theme : Theme
    }


{-| Define the appearance of the Button
-}
type Appearance
    = Primary
    | Secondary


{-| Define the size of the Button
-}
type Size
    = S
    | M
    | L


{-| Look and feel of the Button
-}
type Kind
    = Link
    | Filled
    | Ghost


type alias Theme =
    { primary : Css.Color
    , secondary : Css.Color
    }


{-| Default Configurations
-}
defaultButtonConfig : Config
defaultButtonConfig =
    { appearance = Primary
    , size = M
    , kind = Filled
    , class = ""
    , theme =
        { primary = hex "00d1b2"
        , secondary = hex "333333"
        }
    }


widthFromSize : Size -> Css.Em
widthFromSize size =
    case size of
        S ->
            Css.em 5

        M ->
            Css.em 8

        L ->
            Css.em 16


bgColor : Theme -> Appearance -> Kind -> Css.Color
bgColor theme appearance kind =
    if kind == Link || kind == Ghost then
        rgba 0 0 0 0

    else
        colorFromAppearance theme appearance


decoration : Kind -> List Style
decoration shape =
    case shape of
        Link ->
            [ textDecoration underline
            ]

        Filled ->
            [ textDecoration none
            ]

        Ghost ->
            [ textDecoration none
            ]


colorFromAppearance : Theme -> Appearance -> Css.Color
colorFromAppearance theme appearance =
    case appearance of
        Primary ->
            theme.primary

        Secondary ->
            theme.secondary


textColor : Theme -> Appearance -> Kind -> Css.Color
textColor theme appearance kind =
    case kind of
        Link ->
            colorFromAppearance theme appearance

        Filled ->
            hex "FFFFFF"

        Ghost ->
            colorFromAppearance theme appearance


styledButton : Config -> List (Attribute msg) -> List (Html msg) -> Html msg
styledButton { appearance, size, kind, theme } =
    styled button <|
        [ backgroundColor (bgColor theme appearance kind)
        , border <|
            if kind == Ghost then
                px 1

            else
                px 0
        , borderStyle solid
        , borderColor (colorFromAppearance theme appearance)
        , color (textColor theme appearance kind)
        , padding (Css.em 0)
        , fontSize (Css.em 0.9)
        , width (widthFromSize size)
        , height (Css.em 3)
        , borderRadius (Css.em 0.5)
        , important (outline none)
        ]
            ++ decoration kind


{-| Renders the button
-}
view : String -> Config -> msg -> Html.Html msg
view label config clickMsg =
    styledButton config [ onClick clickMsg, class config.class ] [ text label ] |> toUnstyled
