module Components.Block.Welcome.Stories exposing (stories)

import Components.Block.Welcome.View as Welcome
import UIExplorer exposing (createUI)


stories : UIExplorer.UI a () { hasMenu : Bool }
stories =
    createUI
        "Welcome"
        [ ( "Default", \_ -> Welcome.view, { hasMenu = True } )
        ]
