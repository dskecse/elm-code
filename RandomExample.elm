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
  { dieFace : Int
  }


-- UPDATE

type Msg
  = Roll
  | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      (Model newFace, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ img [ src (dieFaceImage model.dieFace) ] []
    , button [ onClick Roll ] [ text "Roll" ]
    ]

dieFaceImage : Int -> String
dieFaceImage dieFace =
  "/images/" ++ (toString dieFace) ++ ".png"


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)
