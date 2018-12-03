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


{-| Default Configurations
-}
defaultButtonConfig : Config
defaultButtonConfig =
    { appearance = Primary
    , size = M
    , kind = Filled
    , class = ""
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


bgColor : Appearance -> Kind -> Css.Color
bgColor appearance kind =
    if kind == Link || kind == Ghost then
        rgba 0 0 0 0

    else
        colorFromAppearance appearance


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


colorFromAppearance : Appearance -> Css.Color
colorFromAppearance appearance =
    case appearance of
        Primary ->
            hex "00d1b2"

        Secondary ->
            hex "333333"


textColor : Appearance -> Kind -> Css.Color
textColor appearance kind =
    case kind of
        Link ->
            colorFromAppearance appearance

        Filled ->
            hex "FFFFFF"

        Ghost ->
            colorFromAppearance appearance


styledButton : Config -> List (Attribute msg) -> List (Html msg) -> Html msg
styledButton { appearance, size, kind } =
    styled button <|
        [ backgroundColor (bgColor appearance kind)
        , border <|
            if kind == Ghost then
                px 1

            else
                px 0
        , borderStyle solid
        , borderColor (colorFromAppearance appearance)
        , color (textColor appearance kind)
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
