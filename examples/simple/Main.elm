module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Html exposing (Html, a, button, div, i, span, text)
import Html.Attributes exposing (attribute, class, classList, href, id)
import Html.Events exposing (onClick)


type alias Model =
    { isOpen : Bool
    }


initialModel : Model
initialModel =
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


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, view = view, update = update }
