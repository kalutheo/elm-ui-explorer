module Style.Utils exposing (HexaColor(..), bgColor, borderColor, hexToRgb, rec, textColor)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Hex


type HexaColor
    = HexaColor String


rec : List String -> List String -> List String
rec result incoming =
    case incoming of
        [] ->
            result

        _ ->
            rec
                (List.append
                    result
                    [ List.take 2 incoming
                        |> String.join ""
                        |> String.toLower
                    ]
                )
                (List.drop 2 incoming)


hexToRgb : HexaColor -> Color
hexToRgb (HexaColor color) =
    let
        colorsList =
            color
                |> String.split ""
                |> List.tail
                |> Maybe.map (\n -> rec [] n |> List.map Hex.fromString)
                |> Maybe.withDefault [ Ok 0, Ok 0, Ok 0 ]
                |> List.map (\a -> a |> Result.map (\d -> d) |> Result.withDefault 0)

        newColor =
            case colorsList of
                [ r, g, b ] ->
                    rgba255 r g b 1

                _ ->
                    rgba255 0 0 0 1
    in
    newColor


textColor color =
    Font.color <| hexToRgb (HexaColor color)


borderColor color =
    Border.color <| hexToRgb (HexaColor color)


bgColor color =
    Background.color <| hexToRgb (HexaColor color)
