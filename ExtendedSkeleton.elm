import Html exposing (..)


-- MODEL

type alias Model =
  {}


-- UPDATE

type Msg
  = Reset
  | ...

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset ->
      ...


-- VIEW

view : Model -> Html Msg
view model =
  ...


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  ...


-- INIT

init : (Model, Cmd Msg)
init =
  ...
