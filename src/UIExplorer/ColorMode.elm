module UIExplorer.ColorMode exposing (ColorMode(..), colorModeToString)


type ColorMode
    = Dark
    | Light


colorModeToString : ColorMode -> String
colorModeToString colorMode =
    case colorMode of
        Dark ->
            "Dark"

        Light ->
            "Light"
