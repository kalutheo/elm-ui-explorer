module Theme.Icons.Soda exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (clipPath, defs, g, path)
import Svg.Attributes exposing (color, d, fill, version, viewBox, x, y)


view : String -> Int -> Html msg
view c w =
    Svg.svg [ color c, width w, version "1.1", id "Capa_1", x "0px", y "0px", viewBox "0 0 374.14 374.14" ] [ g [] [ g [ id "cup_1_" ] [ g [] [ Svg.path [ d "M225.323,67.323l1.429,0.703l68.025-56.688L272.102,0l-68.025,56.688l-6.054,45.35H79.363l22.675,272.102h158.726 l22.675-272.102h-62.742L225.323,67.323z M260.764,124.713l-22.675,226.751H124.713l-22.675-226.751h92.968l-10.589,79.363 h-48.366l11.338,124.713h68.025l11.338-124.713h-19.659l10.589-79.363H260.764z" ] [] ] ] ], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [], g [] [] ]
