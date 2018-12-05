module Main exposing (main)

import Docs
import Guidelines.Colors as ColorGuide
import Guidelines.Typography as TypographyGuide
import Html
import Html.Attributes exposing (class)
import Markdown
import UIExplorer
    exposing
        ( ExplorerProgram
        , addUICategory
        , app
        , createUI
        , defaultConfig
        , emptyUICategories
        , explore
        , findStory
        )


join : Maybe (Maybe a) -> Maybe a
join mx =
    case mx of
        Just x ->
            x

        Nothing ->
            Nothing


main : ExplorerProgram {} () { hasMenu : Bool }
main =
    app
        (emptyUICategories
            |> addUICategory
                "Getting Started"
                [ createUI
                    "About"
                    [ ( "About", \_ -> Docs.toMarkdown Docs.about, { hasMenu = False } ) ]
                ]
            |> addUICategory
                "Guidelines"
                [ createUI
                    "Principles"
                    [ ( "Principles", \_ -> Docs.toMarkdown Docs.principles, { hasMenu = False } ) ]
                ]
            |> addUICategory
                "Styles"
                [ createUI
                    "Colors"
                    [ ( "Brand", \_ -> ColorGuide.viewBrandColors, { hasMenu = True } )
                    , ( "Neutral", \_ -> ColorGuide.viewNeutralColors, { hasMenu = True } )
                    ]
                , createUI
                    "Typograhy"
                    [ ( "Typograhy", \_ -> TypographyGuide.view, { hasMenu = False } )
                    ]
                ]
        )
        { defaultConfig
            | menuViewEnhancer =
                \m v ->
                    let
                        r =
                            Maybe.map2 (\a b -> ( a, b )) m.selectedUIId m.selectedStoryId

                        maybeStory =
                            Maybe.map (\( a, b ) -> findStory a b m.categories) r
                                |> join
                    in
                    case maybeStory of
                        Just ( _, _, option ) ->
                            if option.hasMenu then
                                v

                            else
                                Html.text ""

                        Nothing ->
                            v
        }
