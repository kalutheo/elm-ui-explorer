module UIExplorer.Plugins.Tabs exposing (Msg(..), update, view)

import Html
import Html.Attributes as Attr
import Html.Events as Events
import UIExplorer


type Msg
    = TabOpened Int


type alias Model =
    { displayedTab : Int }


update : Msg -> Model -> Model
update msg m =
    case msg of
        TabOpened index ->
            { m | displayedTab = index }


view tabs items onTabOpened =
    Html.div [ Attr.class "uie-bg-grey-lightest uie-border uie-mt-8  uie-border-solid uie-border-grey-dark-light" ]
        [ Html.nav [ Attr.class "uie-pl-8 uie-bg-white uie-p-2   uie-border-b uie-shadow  uie-border-grey-light" ]
            (List.indexedMap
                (\index ( title, _, icon ) ->
                    let
                        borders =
                            if index == (List.length items - 1) then
                                []

                            else
                                [ ( "uie-border-r", True ) ]
                    in
                    Html.button
                        [ Attr.classList borders
                        , Attr.class "uie-text-grey uie-text-xs uie-border-grey-light uie-border-solid  uie-p-1 uie-pr-4 uie-mr-2"
                        , Events.onClick (UIExplorer.ExternalMsg (onTabOpened (TabOpened index)))
                        ]
                        [ Html.div [ Attr.class "uie-flex items-center" ]
                            [ Html.div [ Attr.class "uie-mr-1" ] [ icon ]
                            , Html.div [] [ Html.text title ]
                            ]
                        ]
                )
                items
            )
        , Html.section
            [ Attr.class "uie-pl-8 uie-pr-8 uie-pt-4 uie-pb-4" ]
            (List.indexedMap
                (\index ( _, content, _ ) ->
                    case tabs.displayedTab == index of
                        True ->
                            Html.div [ Attr.class "uie-pb-8 uie-mb-4" ]
                                [ content
                                ]

                        False ->
                            Html.text ""
                )
                items
            )
        ]
