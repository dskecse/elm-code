import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char


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
  , age : Int
  }

model : Model
model =
  Model "" "" "" 0


-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordConfirmation String
  | Age String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordConfirmation password ->
      { model | passwordConfirmation = password }

    Age age ->
      case String.toInt age of
        Err _ ->
          model
        Ok age ->
          { model | age = age }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" Name
    , viewInput "text" "Password" Password
    , viewInput "text" "Password confirmation" PasswordConfirmation
    -- FYI: Input type "number" restricts characters to contain numbers only!
    , viewInput "number" "Age" Age
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
      else if not (String.any Char.isUpper model.password) then
        ("red", "Password should contain an uppercase character!")
      else if not (String.any Char.isLower model.password) then
        ("red", "Password should contain a lowercase character!")
      else if not (String.any Char.isDigit model.password) then
        ("red", "Password should contain a numeric character!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
