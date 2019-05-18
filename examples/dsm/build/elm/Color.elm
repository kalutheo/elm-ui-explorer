module Theme.Color exposing (Color, color, getColor, getColorName)

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
                    , color = RawColor.rgb255 76 87 96
                    }
                )
        , primaryVariant =
            Brand
                (PrimaryVariant
                    { name = "primary variant"
                    , color = RawColor.rgb255 215 206 178
                    }
                )
        , secondary =
            Brand
                (Secondary
                    { name = "secondary"
                    , color = RawColor.rgb255 147 168 172
                    }
                )
        , secondaryVariant =
            Brand
                (SecondaryVariant
                    { name = "secondary variant"
                    , color = RawColor.rgb255 165 158 140
                    }
                )
        , alternative =
            Brand
                (Alternative
                    { name = "alternative"
                    , color = RawColor.rgb255 255 0 0
                    }
                )
        , alternativeVariant =
            Brand
                (AlternativeVariant
                    { name = "alternative variant"
                    , color = RawColor.rgb255 255 0 0
                    }
                )
        }
    , neutral =
        { black =
            Neutral
                (Black
                    { name = "black"
                    , color = RawColor.rgb255 34 41 47
                    }
                )
        , greyDarkest =
            Neutral
                (GreyDarkest
                    { name = "grey darkest"
                    , color = RawColor.rgb255 61 72 82
                    }
                )
        , greyDarker =
            Neutral
                (GreyDarker
                    { name = "grey darker"
                    , color = RawColor.rgb255 96 111 123
                    }
                )
        , greyDark =
            Neutral
                (GreyDark
                    { name = "grey dark"
                    , color = RawColor.rgb255 135 149 161
                    }
                )
        , grey =
            Neutral
                (Grey
                    { name = "grey"
                    , color = RawColor.rgb255 184 194 204
                    }
                )
        , greyLight =
            Neutral
                (GreyLight
                    { name = "grey light"
                    , color = RawColor.rgb255 218 225 231
                    }
                )
        , greyLighter =
            Neutral
                (GreyLighter
                    { name = "grey lighter"
                    , color = RawColor.rgb255 241 245 248
                    }
                )
        , greyLightest =
            Neutral
                (GreyLightest
                    { name = "grey lightest"
                    , color = RawColor.rgb255 248 250 252
                    }
                )
        , white =
            Neutral
                (White
                    { name = "white"
                    , color = RawColor.rgb255 255 255 255
                    }
                )
        }
    }


getBrandProperty : BrandColor -> (ColorStyle -> a) -> a
getBrandProperty c callback =
    case c of
        Primary colorStyle ->
            callback colorStyle

        PrimaryVariant colorStyle ->
            callback colorStyle

        Secondary colorStyle ->
            callback colorStyle

        SecondaryVariant colorStyle ->
            callback colorStyle

        Alternative colorStyle ->
            callback colorStyle

        AlternativeVariant colorStyle ->
            callback colorStyle


getNeutralProperty : NeutralColor -> (ColorStyle -> a) -> a
getNeutralProperty c callback =
    case c of
        Black colorStyle ->
            callback colorStyle

        GreyDarkest colorStyle ->
            callback colorStyle

        GreyDarker colorStyle ->
            callback colorStyle

        GreyDark colorStyle ->
            callback colorStyle

        Grey colorStyle ->
            callback colorStyle

        GreyLight colorStyle ->
            callback colorStyle

        GreyLighter colorStyle ->
            callback colorStyle

        GreyLightest colorStyle ->
            callback colorStyle

        White colorStyle ->
            callback colorStyle


getColorName : Color -> String
getColorName c =
    case c of
        Brand brandColor ->
            getBrandProperty brandColor .name

        Neutral neutralColor ->
            getNeutralProperty neutralColor .name


getColor : Color -> RawColor.Color
getColor c =
    case c of
        Brand brandColor ->
            getBrandProperty brandColor .color

        Neutral neutralColor ->
            getNeutralProperty neutralColor .color
