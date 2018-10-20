module View exposing (view)

import Element exposing (..)
import Element.Background as Background
import Style.System as DS
import Style.Utils exposing (bgColor, textColor)



--- https://static.collectui.com/shots/3344049/xplay-music-app-large


viewHeader =
    column [ bgColor DS.purple.base, width fill, height <| px 80 ]
        [ el [ textColor "#FFFFFF", centerX, centerY ] (text "Music Player")
        ]


viewAlbumPreview =
    column [ padding 20 ] [ text "preview" ]


viewPlayer =
    column
        [ width fill
        , bgColor "#FFFFFF"
        ]
        [ viewHeader, viewAlbumPreview ]


view model =
    layout []
        (column
            [ height fill
            , width fill
            , bgColor DS.grey.base
            , padding 80
            ]
            [ viewPlayer
            ]
        )
