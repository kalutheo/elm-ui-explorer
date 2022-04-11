module UIExplorer.ColorMode exposing (ColorMode(..), colorModeToString)


{-|
@docs ColorMode
@docs colorModeToString
--}

{-| This is used to determine the color mode of the UI Explorer.
-}
type ColorMode
    = Dark
    | Light


{-| Convert a colorMode to a string.
-}
colorModeToString : ColorMode -> String
colorModeToString colorMode =
    case colorMode of
        Dark ->
            "Dark"

        Light ->
            "Light"
