port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import MainCss


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "public/main.css", Css.File.compile [ MainCss.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
