module Theme.Color exposing (Color)

import Color as RawColor


type alias ColorStyle =
    { color : RawColor.Color, name : String }


type BrandColor = Primary|PrimaryVariant|Secondary|SecondaryVariant|Alternative|AlternativeVariant

type Color
    = Brand BrandColor

type alias BrandColorEntries = {
  primary:Color,primaryvariant:Color,secondary:Color,secondaryvariant:Color,alternative:Color,alternativevariant:Color
  }
