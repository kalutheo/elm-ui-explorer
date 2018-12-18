module Theme.Typography exposing
    ( Typography
    , getDesc
    , getFamily
    , getName
    , getSize
    , typography
    )


type alias TypographyStyle =
    { size : Int
    , family : String
    , name : String
    , desc : String
    }


type Typography
    = Lead TypographyStyle
    | Title TypographyStyle
    | Subtitle TypographyStyle
    | Paragraph TypographyStyle
    | Small TypographyStyle


type alias TypographyTheme =
    { lead : Typography
    , title : Typography
    , subtitle : Typography
    , paragraph : Typography
    , small : Typography
    }


type alias FontFamily =
    { primary : String, secondary : String }


fonts : FontFamily
fonts =
    { primary = "Noto Sans TC", secondary = "Lato" }


typography : TypographyTheme
typography =
    { lead =
        Lead
            { size = 48
            , family = fonts.primary
            , name = "Lead"
            , desc = "Hero or blog post title"
            }
    , title =
        Title
            { size = 38
            , family = fonts.primary
            , name = "Title"
            , desc = "Article title or section header"
            }
    , subtitle =
        Subtitle
            { size = 22
            , family = fonts.primary
            , name = "Subtitle"
            , desc = "Headline title or subtitle"
            }
    , paragraph =
        Paragraph
            { size = 16
            , family = fonts.secondary
            , name = "Paragraph"
            , desc = "Article body"
            }
    , small =
        Small
            { size = 12
            , family = fonts.secondary
            , name = "Small"
            , desc = "Time stamps, copyrights"
            }
    }



--- Helpers


getFamily : Typography -> String
getFamily typo =
    getProperty typo .family


getName : Typography -> String
getName typo =
    getProperty typo .name


getDesc : Typography -> String
getDesc typo =
    getProperty typo .desc


getSize : Typography -> Int
getSize typo =
    getProperty typo .size


getProperty : Typography -> (TypographyStyle -> a) -> a
getProperty typo callback =
    case typo of
        Lead typographyStyle ->
            callback typographyStyle

        Title typographyStyle ->
            callback typographyStyle

        Subtitle typographyStyle ->
            callback typographyStyle

        Paragraph typographyStyle ->
            callback typographyStyle

        Small typographyStyle ->
            callback typographyStyle
