module Explorer exposing (main)

import Stories.AlbumPreview as AlbumPreview
import UIExplorer exposing (app, createUI, fromUIList)


main =
    app
        (fromUIList
            [ createUI
                "AlbumPreview"
                AlbumPreview.viewStories
            ]
        )
