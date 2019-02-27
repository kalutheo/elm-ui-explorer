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


type Color
    = Brand BrandColor


type alias BrandColorEntries =
    { primary : Color
    , primaryVariant : Color
    , secondary : Color
    , secondaryVariant : Color
    , alternative : Color
    , alternativeVariant : Color
    }


type alias ColorTheme =
    { brand : BrandColorEntries }


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
    }
