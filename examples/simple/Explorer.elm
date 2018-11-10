module Explorer exposing (main, stories)

import Html exposing (div)
import Html.Attributes exposing (style)
import Main exposing (Model, view)
import UIExplorer exposing (app, createUI, fromUIList, renderStories)



{--A list of stories that represent all available states of the UI--}


stories : List ( String, Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]


main =
    app
        (fromUIList
            [ createUI
                "dropdown"
                (renderStories view stories)
            ]
        )
