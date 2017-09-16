module Atom.Toast.Index exposing (..)

import Html exposing (Html, text, div, span, button)
import Html.Attributes exposing (style, class, classList)


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
    , toastClassName : String
    }


selectorToast : ToastModel -> ToastViewModel msg
selectorToast model =
    let
        toastClassName =
            case model.severity of
                Success ->
                    "is-success"

                Error ->
                    "is-danger"

                _ ->
                    "is-warning"

        toastStyle =
            style
                [ ( "paddingRight", "1em" )
                , ( "width", "80%" )
                ]
    in
        { label = model.label
        , isShown = model.isShown
        , toastStyle = toastStyle
        , toastClassName = toastClassName
        }


viewToast : ToastViewModel msg -> Html msg
viewToast model =
    case model.isShown of
        True ->
            div
                [ classList
                    ([ ( "notification", True )
                     , ( model.toastClassName, True )
                     ]
                    )
                , model.toastStyle
                ]
                [ button [ class "delete" ]
                    []
                , span
                    []
                    [ text model.label ]
                ]

        False ->
            div [ class "notification is-info", model.toastStyle ] []


toast : ToastModel -> Html msg
toast =
    viewToast << selectorToast
