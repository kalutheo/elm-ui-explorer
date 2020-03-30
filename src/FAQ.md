## Are elm-ui-explorer and elm-ui related ?

Not at all. The only thing that they share is that they are built with Elm.
However, you can of course make stories of your `elm-ui` views using `elm-ui-explorer` like that:


```elm
stories : UIExplorer.UI a b {}
stories =
    storiesOf
        "MyViewDoneWithElmUI"
        [ ( "Primary"
          , \_ ->
                MyViewDoneWithElmUI.viewPrimary |> toHtml
          , {}
          )
        , ( "Secondary"
          , \_ ->
                MyViewDoneWithElmUI.viewSecondary |> toHtml
          , {}
          )
        ]

toHtml =
    Element.layout []
```


## Why is the Stories type opaque ?

In order to reduce breaking changes, it's a well known [best practice to use Opaque Types](https://medium.com/@ckoster22/advanced-types-in-elm-opaque-types-ec5ec3b84ed2). In order to create Stories, the developer must use the `storiesOf` function provided by the API.


## What does a b c stand for in the Stories type ?

The Stories type is parametrized by three values:

- a : Custom Model entry that can be used to store data related to Plugins
- b : Message Type emitted by the UIExporer main view
- c : Data related to Plugins and used by your Stories


## Why is there a lamba in the definition of the story and what are the arguments it takes  ?

When defining a story, elm-ui-explorer allows to define a lamba function that can help you to use the content of your Custom Model in the story.

Let's say that you have a language setting in you Explorer :
