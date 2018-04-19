module Explorer exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
import Main exposing (Model, view)
import UIExplorer exposing (appWithSnapShotTests, createUI, fromUIList, renderStories)


{--A list of stories that represent all available states of the UI--}


stories : List ( String, Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style [ ( "height", "100px" ) ] ] [ view model ]


main =
    appWithSnapShotTests
        (fromUIList
            [ createUI
                "dropdown"
                (renderStories viewStoriesWrapper stories)
            ]
        )
