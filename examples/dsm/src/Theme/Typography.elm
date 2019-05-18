module Theme.Typography exposing
    ( FontWeight(..)
    , Typography
    , getDesc
    , getFamily
    , getLetterspacing
    , getName
    , getSize
    , getWeight
    , typography
    )


type alias TypographyStyle =
    { size : Int
    , family : String
    , name : String
    , desc : String
    , letterSpacing : Int
    , weight : FontWeight
    }


type Typography
    = Lead TypographyStyle
    | Title TypographyStyle
    | Subtitle TypographyStyle
    | Paragraph TypographyStyle
    | Small TypographyStyle


type FontWeight
    = Bold
    | Regular


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
    { primary = "Montserrat", secondary = "Lato" }


typography : TypographyTheme
typography =
    { lead =
        Lead
            { size = 36
            , family = fonts.primary
            , name = "Lead"
            , desc = "Hero or blog post title"
            , letterSpacing = 0
            , weight = Bold
            }
    , title =
        Title
            { size = 24
            , family = fonts.primary
            , name = "Title"
            , desc = "Article title or section header"
            , letterSpacing = 0
            , weight = Regular
            }
    , subtitle =
        Subtitle
            { size = 20
            , family = fonts.primary
            , name = "Subtitle"
            , desc = "Headline title or subtitle"
            , letterSpacing = 0
            , weight = Regular
            }
    , paragraph =
        Paragraph
            { size = 13
            , family = fonts.secondary
            , name = "Paragraph"
            , desc = "Article body"
            , letterSpacing = 0
            , weight = Regular
            }
    , small =
        Small
            { size = 9
            , family = fonts.secondary
            , name = "Small"
            , desc = "Time stamps, copyrights"
            , letterSpacing = 0
            , weight = Regular
            }
    }



--- Helpers


getFamily : Typography -> String
getFamily typo =
    getProperty typo .family


getLetterspacing : Typography -> Float
getLetterspacing typo =
    getProperty typo .letterSpacing |> toFloat


getWeight : Typography -> FontWeight
getWeight typo =
    getProperty typo .weight


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
