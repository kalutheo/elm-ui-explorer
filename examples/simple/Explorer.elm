module Explorer exposing (..)

import Html.Attributes exposing (style)
import Main exposing (view, Model)
import Html exposing (div)
import UIExplorer exposing (app, renderStories, createUI, fromUIList)


{--A list of stories that represent all available states of the UI--}


stories : List ( String, Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style [ ( "height", "100px" ) ] ] [ view model ]


main =
    app
        (fromUIList
            [ createUI
                "dropdown"
                (renderStories viewStoriesWrapper stories)
            ]
        )
