import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Random


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { dieFaceOne : Int
  , dieFaceTwo : Int
  }


-- UPDATE

type Msg
  = Roll
  | NewFaceOne Int
  | NewFaceTwo Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Cmd.batch [
        Random.generate NewFaceOne getRandomNumericDieFace
      , Random.generate NewFaceTwo getRandomNumericDieFace
      ])

    NewFaceOne newFace ->
      ({ model | dieFaceOne = newFace }, Cmd.none)

    NewFaceTwo newFace ->
      ({ model | dieFaceTwo = newFace }, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ dieFaceImage model.dieFaceOne
    , dieFaceImage model.dieFaceTwo
    , button [ onClick Roll ] [ text "Roll" ]
    ]

dieFaceImage : Int -> Html msg
dieFaceImage dieFace =
  img [ src (numericDieFaceToImage dieFace) ] []

numericDieFaceToImage : Int -> String
numericDieFaceToImage dieFace =
  "/images/" ++ (toString dieFace) ++ ".png"


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)


-- CUSTOM

getRandomNumericDieFace : Random.Generator Int
getRandomNumericDieFace =
  Random.int 1 6
