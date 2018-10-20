module Style.System exposing (grey, neutral, orange, purple)

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
