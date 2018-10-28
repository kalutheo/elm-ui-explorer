module Style.System exposing (grey, neutral, orange, pink, purple, font)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Hex


grey =
    { darkest = "#3D4852"
    , darker = "#606F7B"
    , dark = "#8795A1"
    , base = "#B8C2CC"
    , light = "#DAE1E7"
    , lighter = "#F1F5F8"
    , lightest = "#F8FAFC"
    }


pink =
    { darkest = "#451225"
    , darker = "#6F213F"
    , dark = "#EB5286"
    , base = "#F66D9B"
    , light = "#FA7EA8"
    , lighter = "#FFBBCA"
    , lightest = "#FFEBEF"
    }


purple =
    { darkest = "#21183C"
    , darker = "#382B5F"
    , dark = "#794ACF"
    , base = "#9561E2"
    }


orange =
    { darkest = "#462A16"
    , darker = "#613B1F"
    , dark = "#DE751F"
    , base = "#F6993F"
    }


neutral =
    { white = "#FFFFFF"
    , black = "#FFFFFF"
    }


font =
    { primary =
        [ Font.typeface "Lato"
        , Font.sansSerif
        ]
    }
