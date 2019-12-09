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


view :
    { b | displayedTab : Int }
    -> List ( String, Html.Html (UIExplorer.Msg a) )
    -> (Msg -> a)
    -> Html.Html (UIExplorer.Msg a)
view tabs items onTabOpened =
    Html.div []
        [ Html.nav []
            (List.indexedMap
                (\index ( title, _ ) ->
                    Html.button
                        [ Events.onClick (UIExplorer.ExternalMsg (onTabOpened (TabOpened index)))
                        ]
                        [ Html.text title ]
                )
                items
            )
        , Html.section
            []
            (List.indexedMap
                (\index item ->
                    case tabs.displayedTab == index of
                        True ->
                            Html.div []
                                [ Html.hr [ Attr.style "height" "1px" ] []
                                , item |> Tuple.second
                                ]

                        False ->
                            Html.text ""
                )
                items
            )
        ]
