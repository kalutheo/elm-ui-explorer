module Theme exposing (ColorStyle, brandColorCollection, colors, fonts, neutralColorCollection)

import Color exposing (Color)


type alias ColorStyle =
    { color : Color, name : String }


type alias FontAsset =
    { url : String
    , name : String
    }


type alias FontFamily =
    { primary : String, secondary : String }


type alias TypographyStyle =
    { size : Int
    , family : String
    , name : String
    }


fonts : FontFamily
fonts =
    { primary = "Noto Sans TC", secondary = "Lato" }


colors :
    { brand :
        { blueClassic : ColorStyle
        , blueNavy : ColorStyle
        , premiumGold : ColorStyle
        , vibrantRed : ColorStyle
        }
    , neutral :
        { white : ColorStyle
        , greyLightest : ColorStyle
        , greyLighter : ColorStyle
        , greyLight : ColorStyle
        , grey : ColorStyle
        , greyDark : ColorStyle
        , greyDarker : ColorStyle
        , greyDarkest : ColorStyle
        , black : ColorStyle
        }
    }
colors =
    { brand =
        { premiumGold =
            { name = "Premium Gold"
            , color = Color.rgb255 188 144 61
            }
        , vibrantRed =
            { name = "Vibrant Red"
            , color = Color.rgb255 202 17 4
            }
        , blueNavy =
            { name = "Blue Navy"
            , color = Color.rgb255 17 63 103
            }
        , blueClassic =
            { name = "Blue Classic"
            , color = Color.rgb255 33 88 141
            }
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
            { name = "Grey Light"
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
            { name = "Grey Dark"
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


typography :
    { lead : TypographyStyle
    , title : TypographyStyle
    , subtitle : TypographyStyle
    }
typography =
    { lead =
        { size = 48
        , family = fonts.primary
        , name = "Lead"
        }
    , title =
        { size = 38
        , family = fonts.primary
        , name = "Lead"
        }
    , subtitle =
        { size = 22
        , family = fonts.primary
        , name = "Lead"
        }
    }


brandColorCollection : List ColorStyle
brandColorCollection =
    [ colors.brand.premiumGold
    , colors.brand.vibrantRed
    , colors.brand.blueNavy
    , colors.brand.blueClassic
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
