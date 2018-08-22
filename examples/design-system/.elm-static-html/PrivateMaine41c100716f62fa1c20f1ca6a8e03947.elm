
port module PrivateMaine41c100716f62fa1c20f1ca6a8e03947 exposing (..)

import Platform
import Html exposing (Html)
import ElmHtml.InternalTypes exposing (decodeElmHtml)
import ElmHtml.ToString exposing (FormatOptions, nodeToStringWithOptions, defaultFormatOptions)
import Json.Decode as Json
import Native.Jsonify

import Atom.Button.Stories
import Atom.Global.Colors.Stories
import Atom.Logo.Stories
import Atom.Toast.Stories
import Atom.Typography.Stories
import Molecule.Card.Stories
import Molecule.Menu.Stories
import Organism.CardGrid.Stories
import Organism.Header.Stories
import Organism.Hero.Stories
import Page.Contacts.Stories
import Page.Home.Stories



decode : FormatOptions -> Html msg -> String
decode options view =
    case Json.decodeValue decodeElmHtml (asJsonView view) of
        Err str -> "ERROR:" ++ str
        Ok str -> nodeToStringWithOptions options str
            


render1511864c9cbf28915fc5e0ebd6fd8d67 : Json.Value -> String
render1511864c9cbf28915fc5e0ebd6fd8d67 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Atom.Button.Stories.viewSnapshot
        


rendera7d549b8f9fac5b62d46761f9c3f2f42 : Json.Value -> String
rendera7d549b8f9fac5b62d46761f9c3f2f42 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Atom.Global.Colors.Stories.viewSnapshot
        


rendereb2b6059f8597b7088dd2ea04b700d3d : Json.Value -> String
rendereb2b6059f8597b7088dd2ea04b700d3d _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Atom.Logo.Stories.viewSnapshot
        


render992c986e5b76e6027fd14302ca41bb18 : Json.Value -> String
render992c986e5b76e6027fd14302ca41bb18 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Atom.Toast.Stories.viewSnapshot
        


renderd91243076e716ef8fcbacc2abae2c045 : Json.Value -> String
renderd91243076e716ef8fcbacc2abae2c045 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Atom.Typography.Stories.viewSnapshot
        


render818cf47e91ae37cea292ca3f40ce7557 : Json.Value -> String
render818cf47e91ae37cea292ca3f40ce7557 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Molecule.Card.Stories.viewSnapshot
        


renderc50da4747f198842e3d213a5f9a65676 : Json.Value -> String
renderc50da4747f198842e3d213a5f9a65676 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Molecule.Menu.Stories.viewSnapshot
        


render02550b5b49477b0db6c88ef6b01ae084 : Json.Value -> String
render02550b5b49477b0db6c88ef6b01ae084 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Organism.CardGrid.Stories.viewSnapshot
        


render61fb0c2b2126192439ee246295f6d9ca : Json.Value -> String
render61fb0c2b2126192439ee246295f6d9ca _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Organism.Header.Stories.viewSnapshot
        


render22bbda2e95979844ed8f6f4cab8973f1 : Json.Value -> String
render22bbda2e95979844ed8f6f4cab8973f1 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Organism.Hero.Stories.viewSnapshot
        


rendera90f8d2263d4340b413674caee85466d : Json.Value -> String
rendera90f8d2263d4340b413674caee85466d _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Page.Contacts.Stories.viewSnapshot
        


rendera3ef44e0f112986221cb3167fc7f8127 : Json.Value -> String
rendera3ef44e0f112986221cb3167fc7f8127 _ =
    let
        options = { defaultFormatOptions | newLines = True, indent = 4 }
    in
        (decode options) <| Page.Home.Stories.viewSnapshot
        

renderers : List (Json.Value -> String)
renderers = [ render1511864c9cbf28915fc5e0ebd6fd8d67, rendera7d549b8f9fac5b62d46761f9c3f2f42, rendereb2b6059f8597b7088dd2ea04b700d3d, render992c986e5b76e6027fd14302ca41bb18, renderd91243076e716ef8fcbacc2abae2c045, render818cf47e91ae37cea292ca3f40ce7557, renderc50da4747f198842e3d213a5f9a65676, render02550b5b49477b0db6c88ef6b01ae084, render61fb0c2b2126192439ee246295f6d9ca, render22bbda2e95979844ed8f6f4cab8973f1, rendera90f8d2263d4340b413674caee85466d, rendera3ef44e0f112986221cb3167fc7f8127 ]

init : List (String, Json.Value) -> ((), Cmd msg)
init models =
    let
        mapper renderer (fileOutputName, model) =
            { generatedHtml = renderer model
            , fileOutputName = fileOutputName
            }

        command =
            List.map2 mapper renderers models
                |> htmlOute41c100716f62fa1c20f1ca6a8e03947
    in
        ( (), command )


asJsonView : Html msg -> Json.Value
asJsonView = Native.Jsonify.stringify

port htmlOute41c100716f62fa1c20f1ca6a8e03947 : List { generatedHtml : String, fileOutputName: String } -> Cmd msg

main = Platform.programWithFlags
    { init = init
    , update = (\_ b -> (b, Cmd.none))
    , subscriptions = (\_ -> Sub.none)
    }
    