module Components.Block.Welcome.Stories exposing (stories)

import Components.Block.Welcome.View as Welcome
import UIExplorer exposing (storiesOf)


stories : UIExplorer.UI a () { hasMenu : Bool }
stories =
    storiesOf
        "Welcome"
        [ ( "Default", \_ -> Welcome.view, { hasMenu = True } )
        ]
