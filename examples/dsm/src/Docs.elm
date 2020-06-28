module Docs exposing (about, principles, toMarkdown)

import Html
import Html.Attributes exposing (class)
import Markdown


toMarkdown : String -> Html.Html msg
toMarkdown text =
    Markdown.toHtml [ class "content" ] text


about : String
about =
    """
# About Tasty

*"Le grec parisien"* is a brand created by two French nationals, Joseph (the CEO) and Yannick, (the co-founder), for a Kebab restaurant in Montreal.

**Tasty** is the name of the Design System for digital products and experiences around the restaurant.
The system is composed of guidelines, components and code examples.



![Preview](logo-final.svg)


"""


principles : String
principles =
    """
# Design Principles


- #### Classy;
- #### Premium;
- #### Quality;
- #### Professional;
- #### Simple.


![Preview](stylescape.jpg)




"""
