module Main exposing (Model, Msg(..), initialModel, main, update, view)

import Browser
import Button exposing (..)
import Html exposing (Html, a, button, div, i, input, span, text)
import Html.Attributes exposing (attribute, class, classList, href, id, placeholder, type_)
import Html.Events exposing (onClick)


type alias Model =
    {}


initialModel : Model
initialModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


view : Model -> Html Msg
view model =
    div
        [ class "m-10" ]
        [ div [ class "flex flex-col" ]
            [ div [] [ input [ type_ "text", placeholder "login", class "border border-grey rounded-lg p-2 mb-2 w-full" ] [] ]
            , div [] [ input [ type_ "password", placeholder "password", class "border border-grey rounded-lg p-2 mb-2 w-full" ] [] ]
            , div []
                [ Button.view "Forgot password"
                    { defaultButtonConfig | size = L, class = "text-left w-full", appearance = Secondary, kind = Link }
                    NoOp
                , Button.view "Submit"
                    { defaultButtonConfig | size = S, class = "ml-2 float-right" }
                    NoOp
                , Button.view "Cancel"
                    { defaultButtonConfig | size = S, class = "float-right", appearance = Secondary }
                    NoOp
                ]
            , div []
                []
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, view = view, update = update }
