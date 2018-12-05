module Theme exposing (ColorStyle, colors, fonts)

import Color exposing (Color)


type alias ColorStyle =
    { color : Color, name : String }


type alias FontAsset =
    { url : String
    , name : String
    }


type alias FontFamily =
    { primary : String, secondary : String }


fonts : FontFamily
fonts =
    { primary = "Noto Sans TC", secondary = "Lato" }


colors : List ColorStyle
colors =
    [ { name = "Premium Gold"
      , color = Color.rgb255 188 144 61
      }
    , { name = "Vibrant Red"
      , color = Color.rgb255 202 17 4
      }
    , { name = "Blue Navy"
      , color = Color.rgb255 17 63 103
      }
    , { name = "Blue Classic"
      , color = Color.rgb255 33 88 141
      }
    ]
