module Theme.Types exposing (ColorStyle, Colors, FontFamily, Typography, TypographyStyle)

import Color exposing (Color)



-- Colors


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



-- Typography


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
