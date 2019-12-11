module UIExplorer.Plugins.Review exposing (PluginOption, initErrors, viewEnhancer)

import FeatherIcons
import Html exposing (Html)
import Html.Attributes as Attr
import Reporter
import Review
import Review.Project as Project
import Review.Rule exposing (Rule)
import UIExplorer exposing (ViewEnhancer)


type alias PluginOption =
    { errors : List Review.Error
    , sourceCode : String
    }


initErrors : List Rule -> String -> List Review.Error
initErrors config sourceCode =
    Review.review config Project.new (file sourceCode)


{-| This is the part that allows to display notes underneath the view
-}
viewEnhancer : UIExplorer.Model a b { c | review : PluginOption } -> Html.Html (UIExplorer.Msg b)
viewEnhancer model =
    case UIExplorer.getCurrentSelectedStory model of
        Just ( _, _, option ) ->
            viewReviewErrors option.review

        Nothing ->
            Html.text ""


viewReviewErrors : PluginOption -> Html msg
viewReviewErrors options =
    reviewErrors options
        |> List.map viewPart
        |> Html.div []


viewPart : Reporter.TextContent -> Html msg
viewPart { str, color, backgroundColor } =
    Html.span
        [ case color of
            Just ( red, green, blue ) ->
                Attr.style "color" <| "rgb(" ++ String.fromInt red ++ "," ++ String.fromInt green ++ "," ++ String.fromInt blue ++ ")"

            Nothing ->
                Attr.classList []
        , case backgroundColor of
            Just ( red, green, blue ) ->
                Attr.style "background-color" <| "rgb(" ++ String.fromInt red ++ "," ++ String.fromInt green ++ "," ++ String.fromInt blue ++ ")"

            Nothing ->
                Attr.classList []
        ]
        (str
            |> String.lines
            |> List.map Html.text
            |> List.intersperse (Html.br [] [])
        )


reviewErrors : PluginOption -> List Reporter.TextContent
reviewErrors options =
    Reporter.formatReport Reporter.Reviewing
        [ ( file options.sourceCode
          , options.errors
                |> List.map fromReviewError
          )
        ]


fromReviewError : Review.Error -> Reporter.Error
fromReviewError error =
    { moduleName = Review.errorModuleName error
    , ruleName = Review.errorRuleName error
    , message = Review.errorMessage error
    , details = Review.errorDetails error
    , range = Review.errorRange error
    , hasFix = Review.errorFixes error /= Nothing
    }


file : String -> { path : String, source : String }
file source =
    { path = "SOURCE CODE", source = source }
