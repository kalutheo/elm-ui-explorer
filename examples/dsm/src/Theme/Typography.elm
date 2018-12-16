module Theme.Typography exposing (fonts, typography)

import Theme.Types exposing (FontFamily, Typography)


fonts : FontFamily
fonts =
    { primary = "Noto Sans TC", secondary = "Lato" }


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
