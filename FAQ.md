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

See more detail here: [examples/dsm/src/Components/Header/Stories.elm](examples/dsm/src/Components/Header/Stories.elm)


## Why is the Stories type opaque ?

In order to reduce breaking changes, it's a well known [best practice to use Opaque Types](https://medium.com/@ckoster22/advanced-types-in-elm-opaque-types-ec5ec3b84ed2). In order to create Stories, the developer must use the [storiesOf](https://package.elm-lang.org/packages/kalutheo/elm-ui-explorer/latest/UIExplorer#storiesOf) function provided by the API.


## What does a b c stand for in the Stories type ?

The Stories type is parametrized by three values:

- a : Custom Model entry that can be used to store data related to Plugins
- b : Message Type emitted by the UIExporer main view
- c : Data related to Plugins and used by your Stories


## Why is there a lamba in the definition of the story and what are the arguments it takes  ?

When defining a story, `elm-ui-explorer` allows us to define a lambda function that can help you to bring interactivity to your stories.

Let's say that you defined some [locale](https://en.wikipedia.org/wiki/Locale_(computer_software)) in your model:

```elm
type Locale
    = En
    | Fr
    | De

type alias Model =
    { locale : Locale }
```

Then you can use this value in your stories by accessing your [customModel](https://package.elm-lang.org/packages/kalutheo/elm-ui-explorer/latest/UIExplorer#Model):

```elm
storiesOf
    "Button"
    [ ( "Primary", \m -> button (buttonLabel m.customModel.locale) "pink", {} )
    , ( "Secondary", \m -> button (buttonLabel m.customModel.locale) "violet", {} )
    ]
```

See more detail here: [examples/button/ExplorerWithLocale.elm](examples/button/ExplorerWithLocale.elm)
