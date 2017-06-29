module Atom.Button exposing (..)

import Html.Attributes exposing (class)
import Html exposing (Html, text, button)
import StoryBook.Update exposing (Msg)
import Elegant exposing (..)


type alias ButtonModel =
    { label : String }


type alias ButtonViewModel =
    { label : String
    , isLoading : Bool
    , buttonStyle : Html.Attribute Msg
    }


selectorButton : ButtonModel -> ButtonViewModel
selectorButton model =
    let
        label =
            ">>" ++ model.label

        buttonStyle =
            style
                [ margin medium
                ]
    in
        { label = label, isLoading = False, buttonStyle = buttonStyle }


viewButton : ButtonViewModel -> Html Msg
viewButton model =
    button [ model.buttonStyle, class "button is-primary" ] [ text model.label ]


customButton : ButtonModel -> Html Msg
customButton =
    viewButton << selectorButton


story : Html Msg
story =
    customButton { label = "Ok" }
