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
    }
