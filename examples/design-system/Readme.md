## Design System

A [Design System](https://airbnb.design/building-a-visual-language/) can help frontend developers and designers to define a unified set of UX & Design rules.
Elm UI Explorer makes building such system in Elm a breeze :


<center>
<img src="design-system-explorer.gif" width="600" />
</center>

[Atomic Design](http://bradfrost.com/blog/post/atomic-web-design/) is the methodology used to build the Design System.


### Structure

- public : Contains static assets such as html and css
- src : Source of the Design System
- elm-package : Describes Elm packages dependencies
- package.json : Describes Node packages dependencies


### How to run the UI Explorer

- run ```npm i``` to install node packages
- run ```npm start``` to run the explorer

### Notes

- This project was bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).
- CSS is powered by the wonderful [bulma framework](http://bulma.io/)
