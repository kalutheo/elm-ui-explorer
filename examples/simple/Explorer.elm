module Explorer exposing (main, stories)

import Browser
import Browser.Navigation as Navigation
import Html exposing (div)
import Html.Attributes exposing (style)
import Main
import UIExplorer exposing (Msg(..), UICategory, app, createUI, fromUIList, renderStories, view)
import Url


type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    , explorer : UIExplorer.Model
    }



{--A list of stories that represent all available states of the UI--}


stories : List ( String, Main.Model )
stories =
    [ ( "Default", { isOpen = False, entries = [ "titi", "toto" ] } ), ( "Opened", { isOpen = True, entries = [ "yo", "ya" ] } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Main.Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style "height" "100px" ] [ Main.view model ]


categories =
    fromUIList
        [ createUI
            "dropdown"
            (renderStories viewStoriesWrapper stories)
        ]


type Msg
    = UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | ExlporerMsg UIExplorer.Msg


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { url = url
      , key = key
      , explorer = UIExplorer.initModelFromUrl categories url key
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model
                | url = location
                , explorer = UIExplorer.changeUrl model.explorer location
              }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )

        ExlporerMsg subMsg ->
            let
                ( updatedExplorerModel, explorerCmd ) =
                    UIExplorer.update subMsg model.explorer
            in
            ( { model | explorer = updatedExplorerModel }, Cmd.map ExlporerMsg explorerCmd )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "My Storybook Elm :-)"
                , body =
                    [ Html.map ExlporerMsg (view model.explorer)
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }
