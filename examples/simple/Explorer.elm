module Explorer exposing (main, stories)

import Browser
import Browser.Navigation as Navigation
import Html exposing (div)
import Html.Attributes exposing (style)
import Main
import UIExplorer exposing (Msg, UICategory, app, createUI, fromUIList, renderStories, view)
import Url


type alias Model =
    { categories : List UICategory
    , selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    , selectedCategory : Maybe String
    , url : Url.Url
    , key : Navigation.Key
    }



{--A list of stories that represent all available states of the UI--}


stories : List ( String, Main.Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


categories =
    []


type Msg
    = UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | ExlporerMsg UIExplorer.Msg


init flags url key =
    let
        { selectedUIId, selectedStoryId, selectedCategory } =
            UIExplorer.initModelFromUrl url
    in
    ( { categories = categories
      , selectedUIId = selectedUIId
      , selectedStoryId = selectedStoryId
      , selectedCategory = selectedCategory
      , url = url
      , key = key
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            let
                { selectedUIId, selectedStoryId, selectedCategory } =
                    UIExplorer.initModelFromUrl location
            in
            ( { model
                | url = location
                , selectedUIId = selectedUIId
                , selectedStoryId = selectedStoryId
                , selectedCategory = selectedCategory
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
            ( model, Cmd.none )


main : Program {} Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "Storybook Elm"
                , body =
                    [ Html.map ExlporerMsg (view model)
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }
