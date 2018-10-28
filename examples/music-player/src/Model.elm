module Model exposing (Album, Model, PlayList, Track, mockAlbum, model)


type alias Model =
    { album : Album
    , isPlaying : Bool
    , selectedTrack : Maybe Track
    }


type alias Album =
    { cover : String
    , title : String
    , playlist : PlayList
    }


type alias PlayList =
    List Track


type alias Track =
    { url : String
    , name : String
    , duration : Int
    }


model : Model
model =
    { album = mockAlbum
    , isPlaying = False
    , selectedTrack = Nothing
    }


mockAlbum : Album
mockAlbum =
    { cover = "https://i.scdn.co/image/d025af49bb84dbb26393f42ff9646f1c748c3035"
    , title = "Menu Best Of"
    , playlist =
        [ { url = "https://p.scdn.co/mp3-preview/fb897f080a9c6765cc9178d48abcb4d6f81b472c"
          , name = "Viens voir le docteur - Dirty moog mix"
          , duration = 322213
          }
        , { url = "https://p.scdn.co/mp3-preview/887d0e4b4aa31b5c4ed971394dbc21573aaa4e8c"
          , name = "Nirvana"
          , duration = 338840
          }
        , { url = "https://p.scdn.co/mp3-preview/2aac3d146c048482bea5493a0d7b44ccc4749b65"
          , name = "Né ici"
          , duration = 274080
          }
        ]
    }
