import Html exposing (..)
import Html.Attributes exposing (src, style, for, id, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  , error : Maybe Http.Error
  }


-- UPDATE

type Msg
  = MorePlease
  | NewGif (Result Http.Error String)
  | NewTopic String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif model.topic)

    NewGif (Ok newUrl) ->
      ({ model | gifUrl = newUrl, error = Nothing }, Cmd.none)

    NewGif (Err error) ->
      ({ model | error = Just error }, Cmd.none)

    NewTopic newTopic ->
      ({ model | topic = newTopic }, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div []
        [ label [ for "topic" ] [ text "Topic: " ]
        , input [ id "topic", type_ "text", value model.topic, onInput NewTopic ] []
        ]
    , select [ onInput NewTopic ]
        [ option [] [ text "Choose a topic" ]
        , option [ value "cats" ] [ text "Cats" ]
        , option [ value "dogs" ] [ text "Dogs" ]
        , option [ value "bats" ] [ text "Bats" ]
        , option [ value "samurai" ] [ text "Samurai" ]
        ]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [ src model.gifUrl ] []
    , errorMessage model
    ]

errorMessage : Model -> Html msg
errorMessage model =
  case model.error of
    Just error ->
      div [ style [("color", "red")] ]
        [ text ("An error has occurred: " ++ toString error) ]

    Nothing ->
      div [] []


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Msg)
init =
  (Model "cats" "/images/waiting.gif" Nothing, Cmd.none)


-- HTTP

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif (Http.get url decodeGifUrl)

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string
