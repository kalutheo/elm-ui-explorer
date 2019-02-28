module Theme.Color exposing (Color)

import Color as RawColor


type alias ColorStyle =
    { color : RawColor.Color, name : String }


type BrandColor
    = Primary ColorStyle
    | PrimaryVariant ColorStyle
    | Secondary ColorStyle
    | SecondaryVariant ColorStyle
    | Alternative ColorStyle
    | AlternativeVariant ColorStyle


type NeutralColor
    = Black ColorStyle
    | GreyDarkest ColorStyle
    | GreyDarker ColorStyle
    | GreyDark ColorStyle
    | Grey ColorStyle
    | GreyLight ColorStyle
    | GreyLighter ColorStyle
    | GreyLightest ColorStyle
    | White ColorStyle


type Color
    = Brand BrandColor
    | Neutral NeutralColor


type alias BrandColorEntries =
    { primary : Color
    , primaryVariant : Color
    , secondary : Color
    , secondaryVariant : Color
    , alternative : Color
    , alternativeVariant : Color
    }


type alias NeutralColorEntries =
    { black : Color
    , greyDarkest : Color
    , greyDarker : Color
    , greyDark : Color
    , grey : Color
    , greyLight : Color
    , greyLighter : Color
    , greyLightest : Color
    , white : Color
    }


type alias ColorTheme =
    { brand : BrandColorEntries, neutral : NeutralColorEntries }


color : ColorTheme
color =
    { brand =
        { primary =
            Brand
                (Primary
                    { name = "primary"
                    , color = RawColor.rgb 76 87 96
                    }
                )
        , primaryVariant =
            Brand
                (PrimaryVariant
                    { name = "primary variant"
                    , color = RawColor.rgb 215 206 178
                    }
                )
        , secondary =
            Brand
                (Secondary
                    { name = "secondary"
                    , color = RawColor.rgb 147 168 172
                    }
                )
        , secondaryVariant =
            Brand
                (SecondaryVariant
                    { name = "secondary variant"
                    , color = RawColor.rgb 165 158 140
                    }
                )
        , alternative =
            Brand
                (Alternative
                    { name = "alternative"
                    , color = RawColor.rgb 255 0 0
                    }
                )
        , alternativeVariant =
            Brand
                (AlternativeVariant
                    { name = "alternative variant"
                    , color = RawColor.rgb 255 0 0
                    }
                )
        }
    , neutral =
        { black =
            Neutral
                (Black
                    { name = "black"
                    , color = RawColor.rgb 34 41 47
                    }
                )
        , greyDarkest =
            Neutral
                (GreyDarkest
                    { name = "grey darkest"
                    , color = RawColor.rgb 61 72 82
                    }
                )
        , greyDarker =
            Neutral
                (GreyDarker
                    { name = "grey darker"
                    , color = RawColor.rgb 96 111 123
                    }
                )
        , greyDark =
            Neutral
                (GreyDark
                    { name = "grey dark"
                    , color = RawColor.rgb 135 149 161
                    }
                )
        , grey =
            Neutral
                (Grey
                    { name = "grey"
                    , color = RawColor.rgb 184 194 204
                    }
                )
        , greyLight =
            Neutral
                (GreyLight
                    { name = "grey light"
                    , color = RawColor.rgb 218 225 231
                    }
                )
        , greyLighter =
            Neutral
                (GreyLighter
                    { name = "grey lighter"
                    , color = RawColor.rgb 241 245 248
                    }
                )
        , greyLightest =
            Neutral
                (GreyLightest
                    { name = "grey lightest"
                    , color = RawColor.rgb 248 250 252
                    }
                )
        , white =
            Neutral
                (White
                    { name = "white"
                    , color = RawColor.rgb 255 255 255
                    }
                )
        }
    }
