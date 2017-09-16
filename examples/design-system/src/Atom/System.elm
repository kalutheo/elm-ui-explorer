module Atom.System exposing (..)

import Color exposing (..)
import Color.Convert as ColorConvert


hexToColor color =
    case ColorConvert.hexToColor color of
        Ok c ->
            c

        Err c ->
            white


colors =
    { primary = "#db7093"
    , secondary = "#ff6347"
    , success = "hsl(141, 71%, 48%)"
    , warning = "hsl(48, 100%, 67%)"
    , danger = "hsl(348, 100%, 61%)"
    , light = "hsl(0, 0%, 96%)"
    , gray = "hsl(0, 0%, 21%)"
    , black = "hsl(0, 0%, 4%)"
    }
