module Style.System exposing (..)

import Css exposing (..)


size =
    { artworkSize = (px 280)
    , playerHeight = (px 400)
    }


colors =
    { primary = "#291720" |> hex
    , secondary = "#4a293a" |> hex
    , light = "#f0edee" |> hex
    , selected = "#39202d" |> hex
    , warm = "#d90368" |> hex
    }


fonts =
    { primary = [ "Lato" ]
    }
