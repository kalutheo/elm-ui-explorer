# Button
The Button should be used to trigger user actions.
Some examples of interactions:
  - Submit a form
  - Cancel an order
  - Toggle a menu visibility
  - Play a media

## Usage

```elm
import Button exposing (..)
Button.view "Submit" defaultButtonConfig ()
```
## Links:
  - [UX Planet - Basic rules for button](https://uxplanet.org/7-basic-rules-for-button-design-63dcdf5676b4)

### `Config`
```elm
type alias Config  =
    { appearance : Button.Appearance, size : Button.Size, kind : Button.Kind, class : String.String }
```
 Option to customize the Button


---


### `Size`
```elm
type Size  
    = S \n    | M \n    | L
```
 Define the size of the Button


---


### `Kind`
```elm
type Kind  
    = Link \n    | Filled \n    | Ghost
```
 Look and feel of the Button


---


### `Appearance`
```elm
type Appearance  
    = Primary \n    | Secondary
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
