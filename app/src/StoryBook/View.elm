module StoryBook.View exposing (..)

import Html exposing (Html, aside, ul, li, a, text, div, section, h1, h2)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import StoryBook.Model exposing (..)
import StoryBook.Update exposing (..)
import Elegant exposing (..)
import Color exposing (..)


sizes =
    { commonMargin = 40
    , headerHeight = 100
    , headerMargin = 20
    , sidebarWidth = 200
    }


colors =
    { neutral = gray
    }


styles =
    { logo = style [ paddingLeft (Px sizes.commonMargin) ]
    , sidebar =
        style
            [ width (Px sizes.sidebarWidth)
            , top (Px 0)
            , left (Px 0)
            , bottom (Px 0)
            , zIndex -1
            , backgroundColor colors.neutral
            , positionAbsolute
            ]
    , sidebarItem = style [ width (Px sizes.sidebarWidth) ]
    , sidebarItemLink = style [ paddingLeft (Px sizes.commonMargin) ]
    , header =
        style
            [ height (Px sizes.headerHeight)
            , paddingTop (Px sizes.headerMargin)
            , borderBottomSolid
            , borderBottomWidth 1
            , borderBottomColor white
            ]
    }


viewSidebar : Model -> Html Msg
viewSidebar model =
    div [ class "column" ]
        [ div
            [ styles.sidebar
            ]
            []
        , viewMenu model.stories model.selectedStoryId
        ]


viewHeader : Html msg
viewHeader =
    section
        [ class "hero is-primary"
        , styles.header
        ]
        [ div []
            [ div [ styles.logo ]
                [ h1 [ class "title" ]
                    [ text "ELM" ]
                , h2 [ class "subtitle" ]
                    [ text "Storybook" ]
                ]
            ]
        ]


viewMenuItem : StoryId -> Story -> Html Msg
viewMenuItem selectedStoryId story =
    let
        isSelected =
            story.id == selectedStoryId

        linkClass =
            if isSelected then
                "is-active"
            else
                ""
    in
        li [ styles.sidebarItem ]
            [ a [ class linkClass, onClick (SelectStory story), styles.sidebarItemLink ]
                [ text (story.id |> toString) ]
            ]


viewMenu : Stories -> StoryId -> Html Msg
viewMenu stories selectedStoryId =
    aside [ class "menu", style [ marginTop (Px 0) ] ]
        [ ul [ class "menu-list" ]
            (List.map (viewMenuItem selectedStoryId) stories)
        ]
