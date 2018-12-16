module Theme exposing (ColorStyle, TypographyStyle, brandColorCollection, colors, fonts, neutralColorCollection, typographyCollection)

import Color exposing (Color)


type alias ColorStyle =
    { color : Color, name : String }


type alias Colors =
    { brand :
        { alternative : ColorStyle
        , alternativeVariant : ColorStyle
        , primary : ColorStyle
        , primaryVariant : ColorStyle
        , secondary : ColorStyle
        , secondaryVariant : ColorStyle
        }
    , neutral :
        { black : ColorStyle
        , grey : ColorStyle
        , greyDark : ColorStyle
        , greyDarker : ColorStyle
        , greyDarkest : ColorStyle
        , greyLight : ColorStyle
        , greyLighter : ColorStyle
        , greyLightest : ColorStyle
        , white : ColorStyle
        }
    }


type alias TypographyStyle =
    { size : Int
    , family : String
    , name : String
    , desc : String
    }


type alias Typography =
    { lead : TypographyStyle
    , title : TypographyStyle
    , subtitle : TypographyStyle
    , paragraph : TypographyStyle
    , small : TypographyStyle
    }


type alias FontAsset =
    { url : String
    , name : String
    }


type alias FontFamily =
    { primary : String, secondary : String }


fonts : FontFamily
fonts =
    { primary = "Noto Sans TC", secondary = "Lato" }



-- colors --


premiumGold =
    { name = "Premium Gold"
    , color = Color.rgb255 188 144 61
    }


vibrantRed =
    { name = "Vibrant Red"
    , color = Color.rgb255 202 17 4
    }


blueNavy =
    { name = "Blue Navy"
    , color = Color.rgb255 17 63 103
    }


blueClassic =
    { name = "Blue Classic"
    , color = Color.rgb255 33 88 141
    }


unkown =
    { name = "Unkown"
    , color = Color.rgb255 0 0 0
    }


colors : Colors
colors =
    { brand =
        { primary = vibrantRed
        , primaryVariant = vibrantRed
        , secondary = blueNavy
        , secondaryVariant = blueClassic
        , alternative = premiumGold
        , alternativeVariant = unkown
        }
    , neutral =
        { white =
            { name = "White"
            , color = Color.rgb 1 1 1
            }
        , greyLightest =
            { name = "Grey Lightest"
            , color = Color.rgb 0.9 0.9 0.9
            }
        , greyLighter =
            { name = "Grey Lighter"
            , color = Color.rgb 0.8 0.8 0.8
            }
        , greyLight =
            { name = "Grey Light"
            , color = Color.rgb 0.7 0.7 0.7
            }
        , grey =
            { name = "Grey"
            , color = Color.rgb 0.5 0.5 0.5
            }
        , greyDark =
            { name = "Grey Dark"
            , color = Color.rgb 0.3 0.3 0.3
            }
        , greyDarker =
            { name = "Grey Darker"
            , color = Color.rgb 0.2 0.2 0.2
            }
        , greyDarkest =
            { name = "Grey Darkest"
            , color = Color.rgb 0.1 0.1 0.1
            }
        , black =
            { name = "Black"
            , color = Color.rgb 0 0 0
            }
        }
    }


typography : Typography
typography =
    { lead =
        { size = 48
        , family = fonts.primary
        , name = "Lead"
        , desc = "Hero or blog post title"
        }
    , title =
        { size = 38
        , family = fonts.primary
        , name = "Title"
        , desc = "Article title or section header"
        }
    , subtitle =
        { size = 22
        , family = fonts.primary
        , name = "Subtitle"
        , desc = "Headline title or subtitle"
        }
    , paragraph =
        { size = 16
        , family = fonts.secondary
        , name = "Paragraph"
        , desc = "Article body"
        }
    , small =
        { size = 12
        , family = fonts.secondary
        , name = "Small"
        , desc = "Time stamps, copyrights"
        }
    }


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
