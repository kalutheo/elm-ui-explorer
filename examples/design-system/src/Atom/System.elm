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
    { primary = hexToColor "#db7093"
    , secondary = hexToColor "#ff6347"
    , success = hexToColor "#c9cba3"
    , warning = hexToColor "#ffe1a8"
    , danger = hexToColor "#e26d5c"
    , light = white
    , gray2 = hexToColor "#f7f9f9"
    , gray15 = hexToColor "#d9d9d9"
    , gray35 = hexToColor "#a5a5a5"
    , gray50 = hexToColor "#808080"
    , gray65 = hexToColor "#595959"
    , gray73 = hexToColor "#444444"
    , gray87 = hexToColor "#222222"
    , black = hexToColor "#000000"
    }
