module View exposing (view, viewAlbumPreview)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Html exposing (i)
import Html.Attributes exposing (class, style)
import Msg exposing (..)
import Style.System as DS
import Style.Utils exposing (bgColor, textColor)
import Tuple



--- https://static.collectui.com/shots/3344049/xplay-music-app-large


viewHeader model =
    column
        [ bgColor DS.pink.darkest
        , width fill
        , height <| px 60
        , Border.roundEach
            { topLeft = 10
            , topRight = 10
            , bottomLeft = 0
            , bottomRight = 0
            }
        ]
        [ el
            [ Font.family DS.font.primary
            , Font.size 16
            , textColor DS.neutral.white
            , centerX
            , centerY
            ]
            (text model.album.title)
        ]


viewControlButton icon clickMessage =
    el
        [ height <|
            px 0
        , width fill
        , centerY
        , onClick clickMessage
        ]
    <|
        Element.html
            (i
                [ class <| "fa fa-fw " ++ icon
                , style "margin" "auto"
                , style "color" "white"
                , style "font-size" "32px"
                , style "line-height" "0px"
                ]
                [ Html.text "" ]
            )


viewPlayButton isPlaying =
    let
        props =
            if isPlaying then
                ( Pause, "fa-pause" )

            else
                ( Play, "fa-play" )
    in
    viewControlButton (Tuple.second props) (Tuple.first props)


viewPrevButton =
    viewControlButton "fa-fast-backward" Previous


viewNextButton =
    viewControlButton "fa-fast-forward" Next


viewPlayerControls isPlaying =
    row
        [ width fill
        , height <| px 60
        , centerY
        ]
        [ viewPrevButton
        , viewPlayButton isPlaying
        , viewNextButton
        ]


viewAlbumPreview previewModel =
    column
        [ padding 0
        , Background.uncropped previewModel.cover
        , width fill
        , height <| px 280
        ]
        [ el
            [ Background.color <| rgba255 0 0 0 0.4
            , mouseOver [ Background.color (rgba255 41 23 32 0.8) ]
            , width fill
            , height fill
            ]
            (viewPlayerControls
                previewModel.isPlaying
            )
        ]


viewPlayer model =
    let
        previewModel =
            { cover = model.album.cover, isPlaying = model.isPlaying }
    in
    column
        [ width <| px 280
        , bgColor DS.neutral.white
        , Border.rounded 10
        , centerX
        ]
        [ viewHeader model, viewAlbumPreview previewModel ]


view model =
    layout []
        (column
            [ height fill
            , width fill
            , bgColor DS.neutral.white
            , padding 80
            ]
            [ viewPlayer model
            ]
        )
