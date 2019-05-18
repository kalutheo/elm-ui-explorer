module Guidelines.Typography exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Theme.Typography
    exposing
        ( Typography
        , getDesc
        , getFamily
        , getName
        , getSize
        , typography
        )


typographyCollection : List Typography
typographyCollection =
    [ typography.lead
    , typography.title
    , typography.subtitle
    , typography.paragraph
    , typography.small
    ]


boxWidth =
    800


sentence =
    "The quick brown fox jumps over the lazy dog"


text options label =
    Element.paragraph
        options
        [ Element.text label ]


typoDetail label infos content usage =
    Element.column
        [ spacing 10
        ]
        [ Element.row
            [ Border.color (rgb 0.8 0.8 0.8)
            , width (px boxWidth)
            , paddingEach { top = 0, right = 0, bottom = 8, left = 0 }
            , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
            ]
            [ Element.row
                [ Font.color (rgb 0.4 0.4 0.4)
                ]
                [ Element.text label ]
            , Element.row
                [ Font.color (rgb 0.6 0.6 0.6)
                , Font.size 14
                , alignRight
                ]
                [ Element.text infos ]
            ]
        , Element.column [ spacing 20 ]
            [ content
            , Element.row
                [ Font.size 14
                , Font.color (rgb 0.4 0.4 0.4)
                , Background.color (rgb 0.9 0.9 0.9)
                , Border.color (rgb 0.5 0.5 0.5)
                , Border.solid
                , width (px boxWidth)
                , padding 10
                , Border.widthEach { bottom = 0, left = 6, right = 0, top = 0 }
                ]
                [ Element.text <| "Usage : " ++ usage ]
            ]
        ]


viewTypos content =
    Element.layout []
        (Element.column
            [ spacing 80
            , width <| px boxWidth
            ]
            content
        )


viewText family size =
    text
        [ Font.family
            [ Font.typeface family
            , Font.sansSerif
            ]
        , Font.size size
        ]
        sentence


viewTypoItem : Typography -> Element msg
viewTypoItem typo =
    let
        info =
            String.fromInt (getSize typo) ++ "px" ++ " / " ++ getFamily typo
    in
    typoDetail (getName typo)
        info
        (viewText (getFamily typo) (getSize typo))
        (getDesc typo)


view =
    viewTypos (typographyCollection |> List.map viewTypoItem)
