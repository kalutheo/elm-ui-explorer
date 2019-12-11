module RawContent exposing (note, sourceCode, storySourceCode)


storySourceCode : String
storySourceCode =
    """
```elm
  module Explorer exposing (main)

  import Button exposing (Appearance(..), Kind(..), Size(..), defaultButtonConfig)
  import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)


  main : UIExplorerProgram {} () {}
  main =
      explore
          defaultConfig
          [ storiesOf
              "Button"
              [ ( "Primary", \\_ -> Button.view "Submit" defaultButtonConfig (), {} )
              , ( "Secondary", \\_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), {} )
              , ( "Small", \\_ -> Button.view "Submit" { defaultButtonConfig | size = S } (), {} )
              , ( "Large", \\_ -> Button.view "Submit" { defaultButtonConfig | size = L } (), {} )
              , ( "Link", \\_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } (), {} )
              , ( "GhostPrimary", \\_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } (), {} )
              , ( "GhostSecondary", \\_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), {} )
              ]
          ]
```
"""


sourceCode : String
sourceCode =
    """module Main exposing (f)
import NotUsed
import SomeModule exposing (notUsed)
type SomeCustomType
  = UsedConstructor
  | NotUsedConstructor
f : Int -> SomeCustomType
f x =
  let
    _ = Debug.log "x" x
  in
  UsedConstructor
g n = n + 1
"""


note : String
note =
    """
# Modules
- [Button](#button)

# Button
- [Config](#config)
- [Size](#size)
- [Kind](#kind)
- [Appearance](#appearance)
- [defaultButtonConfig](#defaultbuttonconfig)
- [view](#view)

## Button
The Button should be used to trigger user actions.
Some examples of interactions:
- Submit a form
- Cancel an order
- Toggle a menu visibility
- Play a media
```elm
import Button exposing (..)
Button.view "Submit" defaultButtonConfig ()
```
## Links:
- [UX Planet - Basic rules for button](https://uxplanet.org/7-basic-rules-for-button-design-63dcdf5676b4)

### `Config`
```elm
type alias Config  =
{ appearance : Button.Appearance, size : Button.Size, kind : Button.Kind, class : String.String, theme : Button.Theme }
```
Option to customize the Button


---


### `Size`
```elm
type Size
= S
| M
| L
```
Define the size of the Button


---


### `Kind`
```elm
type Kind
= Link
| Filled
| Ghost
```
Look and feel of the Button


---


### `Appearance`
```elm
type Appearance
= Primary
| Secondary
```
Define the appearance of the Button


---


### `defaultButtonConfig`
```elm
defaultButtonConfig : Config
```
Default Configurations


---


### `view`
```elm
view : String.String -> Config -> msg -> Html.Html msg
```
Renders the button


---


> Generated with elm: 0.19.0 and elm-docs: 0.4.0

"""
