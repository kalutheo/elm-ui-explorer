module Main exposing (..)

import Html exposing (Html, button, div, div, text, a, span, i)
import Html.Attributes exposing (class, classList, attribute, href, id)
import Html.Events exposing (onClick)


type alias Model =
    { isOpen : Bool
    }


model : Model
model =
    { isOpen = False }


type Msg
    = Toggle


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle ->
            { model
                | isOpen =
                    if model.isOpen then
                        False
                    else
                        True
            }


view : Model -> Html Msg
view model =
    div
        [ classList
            [ ( "dropdown", True )
            , ( "is-active", model.isOpen )
            ]
        ]
        [ div
            [ class "dropdown-trigger" ]
            [ button
                [ onClick Toggle
                , class "button is-info"
                , attribute "aria-haspopup" "true"
                , attribute "aria-controls" "dropdown-menu"
                ]
                [ span [] [ text "MENU" ]
                , span
                    [ class "icon is-small" ]
                    [ i
                        [ class "fa fa-angle-down"
                        , attribute "aria-hidden" "true"
                        ]
                        []
                    ]
                ]
            ]
        , div
            [ class "dropdown-menu"
            , id "dropdown-menu"
            , attribute "role" "menu"
            ]
            [ div
                [ class "dropdown-content" ]
                [ a
                    [ href "#", class "dropdown-item" ]
                    [ text "Contact" ]
                , a
                    [ href "#", class "dropdown-item" ]
                    [ text "About Us" ]
                ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }
