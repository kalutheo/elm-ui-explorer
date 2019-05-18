module Components.Text.Stories exposing (stories)

import Components.Text.View as TextView
import Element exposing (..)
import Theme.Color exposing (color)
import Theme.Typography exposing (typography)
import UIExplorer exposing (storiesOf)


lorem : String
lorem =
    """
Suspendisse varius, est id convallis feugiat, tortor justo dignissim dolor, eu pellentesque diam nisi quis odio. Donec condimentum risus ut arcu accumsan, at viverra lorem accumsan. Aenean fermentum ligula magna, id luctus augue sollicitudin id. Cras posuere metus lorem, eu suscipit lorem porta id. Etiam sed imperdiet libero, non dapibus nunc. Proin sed odio id ante auctor placerat vitae sit amet justo. Integer eget nisi ut dolor molestie cursus. Fusce quis lectus ultrices, condimentum nunc quis, viverra mi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi dictum libero vitae nisl feugiat, eu porta nisl mattis. Nam non mi lacinia, bibendum eros sed, mollis odio. Fusce sit amet enim sollicitudin, convallis lacus vitae, interdum augue. Vestibulum venenatis auctor eros, ut gravida urna cursus vitae.
"""


colors =
    [ color.neutral.black
    , color.neutral.grey
    , color.neutral.greyLight
    , color.brand.primary
    , color.brand.secondary
    , color.brand.secondaryVariant
    ]


textShowcase : Theme.Typography.Typography -> String -> Int -> Element msg
textShowcase typo text s =
    Element.column [ spacing s ]
        (colors
            |> List.map
                (\c ->
                    TextView.text
                        typo
                        c
                        text
                )
        )


stories : UIExplorer.UI a b { hasMenu : Bool }
stories =
    storiesOf
        "Text"
        [ ( "Lead"
          , \_ ->
                toHtml <| textShowcase typography.lead "This is a lead text" 8
          , { hasMenu = True }
          )
        , ( "Title"
          , \_ ->
                toHtml <| textShowcase typography.title "This is a title text" 8
          , { hasMenu = True }
          )
        , ( "Subtitle"
          , \_ ->
                toHtml <| textShowcase typography.subtitle "This is a subtitle text" 8
          , { hasMenu = True }
          )
        , ( "Paragraph"
          , \_ ->
                toHtml <| textShowcase typography.paragraph lorem 20
          , { hasMenu = True }
          )
        ]


toHtml =
    Element.layout []
