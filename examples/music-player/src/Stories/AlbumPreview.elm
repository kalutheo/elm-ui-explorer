module Stories.AlbumPreview exposing (stories, viewStories)

import Element
import Stories.Utils as StoriesUtils
import UIExplorer exposing (renderStories)
import View exposing (viewAlbumPreview)


stories : List ( String, { cover : String, isPlaying : Bool } )
stories =
    [ ( "Cover1", { cover = "https://i.scdn.co/image/2858d626c9e2289b2477b9ce39651252fd0f3ecf", isPlaying = False } )
    , ( "Cover2", { cover = "https://i.scdn.co/image/fe1695269d040873e8bbeab94c865ceaac4891f4", isPlaying = False } )
    ]


viewStories =
    renderStories (StoriesUtils.withElmUi viewAlbumPreview) stories
