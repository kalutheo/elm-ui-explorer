module Theme.Colors exposing (colors)

import Color exposing (Color)
import Theme.Types exposing (Colors)


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
