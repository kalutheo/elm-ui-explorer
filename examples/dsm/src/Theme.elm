module Theme exposing
    ( brandColorCollection
    , neutralColorCollection
    , typographyCollection
    )

import Color exposing (Color)
import Theme.Colors exposing (colors)
import Theme.Types exposing (ColorStyle, TypographyStyle)
import Theme.Typography exposing (typography)


typographyCollection : List TypographyStyle
typographyCollection =
    [ typography.lead
    , typography.title
    , typography.subtitle
    , typography.paragraph
    , typography.small
    ]


brandColorCollection : List ColorStyle
brandColorCollection =
    [ colors.brand.primary
    , colors.brand.secondary
    , colors.brand.secondaryVariant
    , colors.brand.alternative
    ]


neutralColorCollection : List ColorStyle
neutralColorCollection =
    [ colors.neutral.white
    , colors.neutral.greyLightest
    , colors.neutral.greyLighter
    , colors.neutral.greyLight
    , colors.neutral.grey
    , colors.neutral.greyDark
    , colors.neutral.greyDarker
    , colors.neutral.greyDarkest
    , colors.neutral.black
    ]
