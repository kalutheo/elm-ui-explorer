module Theme.Color exposing (Color, color, getColor, getColorName)

import Color as RawColor


type alias ColorStyle =
    { color : RawColor.Color, name : String }


type BrandColor
    = Alternative ColorStyle
    | AlternativeVariant ColorStyle
    | Primary ColorStyle
    | PrimaryVariant ColorStyle
    | Secondary ColorStyle
    | SecondaryVariant ColorStyle


type NeutralColor
    = Black ColorStyle
    | GreyLightest ColorStyle
    | GreyLighter ColorStyle
    | GreyLight ColorStyle
    | Grey ColorStyle
    | GreyDark ColorStyle
    | GreyDarker ColorStyle
    | GreyDarkest ColorStyle
    | White ColorStyle


type Color
    = Brand BrandColor
    | Neutral NeutralColor


type alias ColorTheme =
    { brand :
        { alternative : Color
        , alternativeVariant : Color
        , primary : Color
        , primaryVariant : Color
        , secondary : Color
        , secondaryVariant : Color
        }
    , neutral :
        { black : Color
        , grey : Color
        , greyDark : Color
        , greyDarker : Color
        , greyDarkest : Color
        , greyLight : Color
        , greyLighter : Color
        , greyLightest : Color
        , white : Color
        }
    }


color : ColorTheme
color =
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
            Neutral
                (White
                    { name = "White"
                    , color = RawColor.rgb 1 1 1
                    }
                )
        , greyLightest =
            Neutral
                (GreyLightest
                    { name = "Grey Lightest"
                    , color = RawColor.rgb 0.9 0.9 0.9
                    }
                )
        , greyLighter =
            Neutral
                (GreyLighter
                    { name = "Grey Lighter"
                    , color = RawColor.rgb 0.8 0.8 0.8
                    }
                )
        , greyLight =
            Neutral
                (GreyLight
                    { name = "Grey Light"
                    , color = RawColor.rgb 0.7 0.7 0.7
                    }
                )
        , grey =
            Neutral
                (Grey
                    { name = "Grey"
                    , color = RawColor.rgb 0.5 0.5 0.5
                    }
                )
        , greyDark =
            Neutral
                (GreyDark
                    { name = "Grey Dark"
                    , color = RawColor.rgb 0.3 0.3 0.3
                    }
                )
        , greyDarker =
            Neutral
                (GreyDarker
                    { name = "Grey Darker"
                    , color = RawColor.rgb 0.2 0.2 0.2
                    }
                )
        , greyDarkest =
            Neutral
                (GreyDarkest
                    { name = "Grey Darkest"
                    , color = RawColor.rgb 0.1 0.1 0.1
                    }
                )
        , black =
            Neutral
                (Black
                    { name = "Black"
                    , color = RawColor.rgb 0 0 0
                    }
                )
        }
    }


premiumGold =
    Brand
        (Primary
            { name = "Premium Gold"
            , color = RawColor.rgb255 188 144 61
            }
        )


vibrantRed =
    Brand
        (Primary
            { name = "Vibrant Red"
            , color = RawColor.rgb255 202 17 4
            }
        )


blueNavy =
    Brand
        (Secondary
            { name = "Blue Navy"
            , color = RawColor.rgb255 17 63 103
            }
        )


blueClassic =
    Brand
        (SecondaryVariant
            { name = "Blue Classic"
            , color = RawColor.rgb255 33 88 141
            }
        )


unkown =
    Brand
        (Alternative
            { name = "Unkown"
            , color = RawColor.rgb255 0 0 0
            }
        )


getBrandColor : BrandColor -> RawColor.Color
getBrandColor brandColor =
    case brandColor of
        Alternative colorStyle ->
            colorStyle.color

        AlternativeVariant colorStyle ->
            colorStyle.color

        Primary colorStyle ->
            colorStyle.color

        PrimaryVariant colorStyle ->
            colorStyle.color

        Secondary colorStyle ->
            colorStyle.color

        SecondaryVariant colorStyle ->
            colorStyle.color


getBrandColorName : BrandColor -> String
getBrandColorName brandColor =
    case brandColor of
        Alternative colorStyle ->
            colorStyle.name

        AlternativeVariant colorStyle ->
            colorStyle.name

        Primary colorStyle ->
            colorStyle.name

        PrimaryVariant colorStyle ->
            colorStyle.name

        Secondary colorStyle ->
            colorStyle.name

        SecondaryVariant colorStyle ->
            colorStyle.name


getNeutralColor : NeutralColor -> RawColor.Color
getNeutralColor neutral =
    case neutral of
        Black colorStyle ->
            colorStyle.color

        GreyLightest colorStyle ->
            colorStyle.color

        GreyLighter colorStyle ->
            colorStyle.color

        GreyLight colorStyle ->
            colorStyle.color

        Grey colorStyle ->
            colorStyle.color

        GreyDark colorStyle ->
            colorStyle.color

        GreyDarker colorStyle ->
            colorStyle.color

        GreyDarkest colorStyle ->
            colorStyle.color

        White colorStyle ->
            colorStyle.color


getNeutralColorName : NeutralColor -> String
getNeutralColorName neutral =
    case neutral of
        Black colorStyle ->
            colorStyle.name

        GreyLightest colorStyle ->
            colorStyle.name

        GreyLighter colorStyle ->
            colorStyle.name

        GreyLight colorStyle ->
            colorStyle.name

        Grey colorStyle ->
            colorStyle.name

        GreyDark colorStyle ->
            colorStyle.name

        GreyDarker colorStyle ->
            colorStyle.name

        GreyDarkest colorStyle ->
            colorStyle.name

        White colorStyle ->
            colorStyle.name


getColorName : Color -> String
getColorName c =
    case c of
        Brand brandColor ->
            getBrandColorName brandColor

        Neutral neutralColor ->
            getNeutralColorName neutralColor


getColor : Color -> RawColor.Color
getColor c =
    case c of
        Brand brandColor ->
            getBrandColor brandColor

        Neutral neutralColor ->
            getNeutralColor neutralColor
