module Guidelines.Typography exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Theme exposing (fonts)


boxWidth =
    800


sentence =
    "The quick brown fox jumps over the lazy dog"


lead =
    [ Font.family
        [ Font.typeface fonts.primary
        , Font.sansSerif
        ]
    , Font.size 48
    ]


title =
    [ Font.family
        [ Font.typeface fonts.primary
        , Font.sansSerif
        ]
    , Font.size 38
    ]


subtitle =
    [ Font.family
        [ Font.typeface fonts.secondary
        , Font.sansSerif
        ]
    , Font.color (rgb 0.2 0.2 0.2)
    , Font.size 22
    ]


paragraph =
    [ Font.family
        [ Font.typeface fonts.secondary
        , Font.sansSerif
        ]
    , Font.size 16
    ]


small =
    [ Font.family
        [ Font.typeface fonts.secondary
        , Font.sansSerif
        ]
    , Font.color (rgb 0.2 0.2 0.2)
    , Font.size 12
    ]


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


view =
    viewTypos
        [ typoDetail "Lead"
            ("48px" ++ " / " ++ fonts.primary)
            (text lead sentence)
            "Hero or blog post title"
        , typoDetail "Title"
            ("38px" ++ " / " ++ fonts.primary)
            (text title sentence)
            "Article title or section header"
        , typoDetail "Subtitle"
            ("22px" ++ " / " ++ fonts.secondary)
            (text subtitle sentence)
            "Headline title or subtitle"
        , typoDetail "Body"
            ("16x" ++ " / " ++ fonts.secondary)
            (text paragraph sentence)
            "Article body"
        , typoDetail "Small"
            ("12x" ++ " / " ++ fonts.secondary)
            (text small sentence)
            "Time stamps, copyrights"
        ]
