module Main exposing (main)

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
