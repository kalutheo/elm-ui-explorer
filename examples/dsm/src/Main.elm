module Main exposing (main)

import Components.Block.Welcome.Stories as Welcome
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
        ( UIExplorerProgram
        , addUICategory
        , defaultConfig
        , emptyUICategories
        , exploreWithCategories
        , getCurrentSelectedStory
        , storiesOf
        )


config =
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


main : UIExplorerProgram {} () { hasMenu : Bool }
main =
    exploreWithCategories
        config
        (emptyUICategories
            |> addUICategory
                "Getting Started"
                [ storiesOf
                    "About"
                    [ ( "About", \_ -> Docs.toMarkdown Docs.about, { hasMenu = False } ) ]
                ]
            |> addUICategory
                "Guidelines"
                [ storiesOf
                    "Principles"
                    [ ( "Principles", \_ -> Docs.toMarkdown Docs.principles, { hasMenu = False } ) ]
                ]
            |> addUICategory
                "Styles"
                [ storiesOf
                    "Colors"
                    [ ( "Brand", \_ -> ColorGuide.viewBrandColors, { hasMenu = True } )
                    , ( "Neutral", \_ -> ColorGuide.viewNeutralColors, { hasMenu = True } )
                    ]
                , storiesOf
                    "Typography"
                    [ ( "Typography", \_ -> TypographyGuide.view, { hasMenu = False } )
                    ]
                , storiesOf
                    "Iconography"
                    [ ( "Classic", \_ -> IconographyGuide.viewClassic, { hasMenu = True } )
                    , ( "WithBackground", \_ -> IconographyGuide.viewWithBg, { hasMenu = True } )
                    ]
                , storiesOf
                    "Spacing"
                    [ ( "Spacing", \_ -> SpacingGuide.view, { hasMenu = True } )
                    ]
                ]
            |> addUICategory "Components"
                [ Text.stories
                , Header.stories
                , Button.stories
                , Welcome.stories
                ]
        )
