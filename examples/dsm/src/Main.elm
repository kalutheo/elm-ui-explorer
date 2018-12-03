module Main exposing (main)

import Html
import UIExplorer
    exposing
        ( ExplorerProgram
        , addUICategory
        , app
        , createUI
        , defaultConfig
        , emptyUICategories
        , explore
        )


main : ExplorerProgram {} () {}
main =
    app
        (emptyUICategories
            |> addUICategory
                "Getting Started"
                [ createUI
                    "About"
                    [ ( "About", \_ -> Html.text "Tasty is the name of the design system", {} ) ]
                ]
            |> addUICategory
                "Atoms"
                []
            |> addUICategory
                "Molecules"
                []
            |> addUICategory
                "Organisms"
                []
            |> addUICategory
                "Pages"
                []
        )
        defaultConfig
