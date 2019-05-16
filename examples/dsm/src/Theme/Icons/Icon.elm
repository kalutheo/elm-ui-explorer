module Theme.Icons.Icon exposing (Icon, Size(..), getName, icon, view)

import Color as RawColor
import Html exposing (Html, div)
import Theme.Color exposing (Color, color, getColor)
import Theme.Icons.FrenchFries as FrenchFriesIcon
import Theme.Icons.IceCream as IceCreamIcon
import Theme.Icons.Logo as LogoIcon
import Theme.Icons.Menu as MenuIcon
import Theme.Icons.Pita as PitaIcon
import Theme.Icons.Salad as SaladIcon
import Theme.Icons.Soda as SodaIcon


type alias IconStyle =
    { name : String }


type Size
    = XS
    | S
    | M
    | L


type Icon
    = Salad IconStyle
    | Pita IconStyle
    | FrenchFries IconStyle
    | Soda IconStyle
    | IceCream IconStyle
    | Logo IconStyle
    | Menu IconStyle


type alias IconTheme =
    { pita : Icon
    , salad : Icon
    , frenchFries : Icon
    , soda : Icon
    , iceCream : Icon
    , logo : Icon
    , menu : Icon
    }


icon : IconTheme
icon =
    { salad =
        Salad
            { name = "Salad"
            }
    , pita =
        Pita
            { name = "Pita"
            }
    , frenchFries =
        FrenchFries
            { name = "Frites"
            }
    , soda =
        Soda
            { name = "Soda"
            }
    , iceCream =
        IceCream
            { name = "Ice Cream"
            }
    , logo =
        Logo
            { name = "Logo"
            }
    , menu =
        Menu
            { name = "Menu"
            }
    }


getName : Icon -> String
getName i =
    case i of
        Salad v ->
            v.name

        Pita v ->
            v.name

        FrenchFries v ->
            v.name

        Soda v ->
            v.name

        IceCream v ->
            v.name

        Logo v ->
            v.name

        Menu v ->
            v.name


getSize : Size -> Int
getSize size =
    case size of
        XS ->
            24

        S ->
            32

        M ->
            64

        L ->
            128


view : Color -> Icon -> Size -> Html msg
view color i size =
    let
        c =
            RawColor.toCssString (getColor color)
    in
    case i of
        Salad _ ->
            SaladIcon.view c (getSize size)

        Pita _ ->
            PitaIcon.view c (getSize size)

        FrenchFries _ ->
            FrenchFriesIcon.view c (getSize size)

        Soda _ ->
            SodaIcon.view c (getSize size)

        IceCream _ ->
            IceCreamIcon.view c (getSize size)

        Logo _ ->
            LogoIcon.view c (getSize size)

        Menu _ ->
            MenuIcon.view c (getSize size)
