module Atom.Toast.Index exposing (..)

import Html exposing (Html, text, div, span)
import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)


type Severity
    = Success
    | Warning
    | Error


type alias ToastModel =
    { label : String, isShown : Bool, severity : Severity }


type alias ToastViewModel msg =
    { label : String
    , isShown : Bool
    , toastStyle : Html.Attribute msg
    }


selectorToast : ToastModel -> ToastViewModel msg
selectorToast model =
    let
        toastColor =
            case model.severity of
                Success ->
                    green

                Error ->
                    red

                _ ->
                    yellow

        toastStyle =
            style
                [ backgroundColor toastColor
                , border white
                , textColor white
                , width (Px 400)
                , padding medium
                , margin medium
                ]
    in
        { label = model.label
        , isShown = model.isShown
        , toastStyle = toastStyle
        }


viewToast : ToastViewModel msg -> Html msg
viewToast model =
    case model.isShown of
        True ->
            div [ model.toastStyle ] [ span [] [ text model.label ] ]

        False ->
            div [ model.toastStyle ] []


toast : ToastModel -> Html msg
toast =
    viewToast << selectorToast
