import Html exposing (..)
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
  { name : String
  , password : String
  , passwordConfirmation : String
  }

model : Model
model =
  Model "" "" ""


-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordConfirmation String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordConfirmation password ->
      { model | passwordConfirmation = password }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" Name
    , viewInput "text" "Password" Password
    , viewInput "text" "Password confirmation" PasswordConfirmation
    , viewValidation model
    ]

viewInput : String -> String -> (String -> Msg) -> Html Msg
viewInput inputType name msg =
  input [ type_ inputType, placeholder name, onInput msg ] []

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password /= model.passwordConfirmation then
        ("red", "Passwords do not match!")
      else if (String.length model.password) < 9 then
        ("red", "Password should be at least 9 characters long!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
