module Main exposing (main)

import Components.Button.Stories as Button
import Components.Header.Stories as Header
import Components.Text.Stories as Text
import Docs
import Guidelines.Colors as ColorGuide
import Guidelines.Iconography as IconographyGuide
import Guidelines.Spacing as SpacingGuide
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
        , getCurrentSelectedStory
        )


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
                    "Typography"
                    [ ( "Typography", \_ -> TypographyGuide.view, { hasMenu = False } )
                    ]
                , createUI
                    "Iconography"
                    [ ( "Classic", \_ -> IconographyGuide.viewClassic, { hasMenu = True } )
                    , ( "WithBackground", \_ -> IconographyGuide.viewWithBg, { hasMenu = True } )
                    ]
                , createUI
                    "Spacing"
                    [ ( "Spacing", \_ -> SpacingGuide.view, { hasMenu = True } )
                    ]
                ]
            |> addUICategory "Components"
                [ Text.stories
                , Header.stories
                , Button.stories
                ]
        )
        { defaultConfig
            | menuViewEnhancer =
                \model menuView ->
                    getCurrentSelectedStory model
                        |> Maybe.map
                            (\( _, _, option ) ->
                                if option.hasMenu then
                                    menuView

                                else
                                    Html.text ""
                            )
                        |> Maybe.withDefault (Html.text "")
        }
