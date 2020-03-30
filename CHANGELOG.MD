# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [7.0.0] - 2020-03-30
### Added
- Added the code plugin for displaying elm code in your stories
- Added the tab plugin in order to facilitate the navigation within plugins

### Updated
- Simplified the API of the Notes viewEnhancer



## [6.0.0] - 2020-02-15
### Added
-  allow the use of subscriptions: https://github.com/kalutheo/elm-ui-explorer/pull/40
Thanks @jgrenat


## [5.0.0] - 2020-01-22
### Fixed
- Allow special characters on UI names: https://github.com/kalutheo/elm-ui-explorer/pull/37.
Thanks @lemol

### Added
- Possibility to pass commands to the update function: https://github.com/kalutheo/elm-ui-explorer/pull/36.
Thanks @salvarubiomartinez



## [4.0.0] - 2019-10-27
### Fixed
- More flexible types for the viewEnhancer see https://github.com/kalutheo/elm-ui-explorer/pull/35
thanks @jouderianjr


## [3.0.2] - 2019-08-27
### Fixed
- Fix the sidebar scroll behavior


## [3.0.1] - 2019-08-03
### Fixed
- Sidebar and main contain have now independent scrolling behavior


## [3.0.0] - 2019-08-03
### Added
- Added the possibility to add custom Html in order to customize the logo of the header
- the `logoUrl` field in the config is now  `logo`
- `logoFromHtml` and `logoFromUrl` can be used respectively to add an Html logo or a logo from a url

## [2.0.1] - 2019-05-18
### Fixed
- Fixed logo 404 on the DSM example

## [2.0.0] - 2019-05-18
### Added
- Migrated to Elm 0.19
- Simplified the Api : `storiesOf` is the new way of creating stories for the UI
```elm
storiesOf
            "Button"
            [ ( "SignIn", \_ -> button "Sign In" "pink", {} )
            , ( "SignOut", \_ -> button "Sign Out" "cyan", {} )
            , ( "Loading", \_ -> button "Loading please wait..." "white", {} )
            ]
 ```

- Added Plugins mechanism.
- Added built in Plugins ( Notes, MenuVisibility)
- Added new design
- Added Customization options for the header
- Added new  button example

### Changed
- `app` has been renamed to `explore`
- `emptyUICategories` is now  `createCategories`
- `addUICategory` is now `category`
- updated the design system example

### Removed
- The `renderStories` function has been removed.  
- Removed music-player and simple example
