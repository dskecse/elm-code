-- import Html exposing (..)
-- import Html exposing (beginnerProgram, div, input, text)
import Html exposing (Html, Attribute, div, input, text)
-- import Html.Attributes exposing (placeholder)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL

type alias Model =
  { content : String
  }

model : Model
model =
  { content = ""
  }


-- UPDATE

type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Text to reverse", onInput Change, customStyle ] []
    , div [ customStyle ] [ text (String.reverse model.content) ]
    ]

customStyle : Attribute msg
customStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]
