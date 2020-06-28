module UIExplorer.Plugins.Tabs exposing
    ( Model
    , Msg(..)
    , initialModel
    , update
    , view
    )

{-|


# Tabs

This plugin allows to display a Tabs below your stories.

See usage [here](https://github.com/kalutheo/elm-ui-explorer/blob/master/examples/button/ExplorerWithNotes.elm)

@docs Model

@docs Msg

@docs initialModel

@docs update

@docs view

-}

import Html
import Html.Attributes as Attr
import Html.Events as Events
import UIExplorer
import UIExplorer.ColorMode exposing (ColorMode(..))


{-| Messages triggered by the tab
-}
type Msg
    = TabOpened Int


{-| Model of the tab
-}
type alias Model =
    { displayedTab : Int }


{-| The initial Model used to initialize the tab
-}
initialModel : Model
initialModel =
    { displayedTab = 0 }


{-| Use this update function to update the tab
-}
update : Msg -> Model -> Model
update msg m =
    case msg of
        TabOpened index ->
            { m | displayedTab = index }


{-| display the tab with this function
-}
view :
    ColorMode
    -> { b | displayedTab : Int }
    -> List ( String, Html.Html (UIExplorer.Msg a), Html.Html (UIExplorer.Msg a) )
    -> (Msg -> a)
    -> Html.Html (UIExplorer.Msg a)
view colorMode tabs items onTabOpened =
    let
        themeClassList =
            case colorMode of
                Light ->
                    [ Attr.class "uie-bg-grey-lightest" ]

                Dark ->
                    [ Attr.class "uie-bg-black" ]

        navClassList =
            case colorMode of
                Light ->
                    [ Attr.class "uie-bg-white" ]

                Dark ->
                    [ Attr.class "uie-bg-black" ]
    in
    Html.div (themeClassList ++ [ Attr.class "uie-border uie-mt-8 uie-border-solid uie-border-grey-dark-light" ])
        [ Html.nav (navClassList ++ [ Attr.class "uie-pl-8  uie-p-2 uie-border-b uie-shadow uie-border-grey-light" ])
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
                        , Attr.class "uie-text-grey uie-text-xs uie-border-grey-light uie-border-solid uie-p-1 uie-pr-4 uie-mr-2"
                        , Events.onClick (UIExplorer.ExternalMsg (onTabOpened (TabOpened index)))
                        ]
                        [ Html.div [ Attr.class "items-center uie-flex" ]
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
                    if tabs.displayedTab == index then
                        Html.div [ Attr.class "uie-pb-8 uie-mb-4" ]
                            [ content
                            ]

                    else
                        Html.text ""
                )
                items
            )
        ]
