module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


-- MODEL


type alias Model =
    { counter : Int
    , input : Int
    , error : Maybe String
    }


initModel : Model
initModel =
    { counter = 0
    , input = 0
    , error = Nothing
    }



-- UPDATE


type Msg
    = AddCount
    | Input String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCount ->
            { model
                | counter = model.counter + model.input
                , input = 0
            }

        Input val ->
            case String.toInt val of
                Ok input ->
                    { model
                        | input = input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }

        Clear ->
            initModel



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text ("Count: " ++ (toString model.counter)) ]
        , input
            [ type' "text"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""
                 else
                    toString model.input
                )
            ]
            []
        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button
            [ type' "button"
            , onClick AddCount
            ]
            [ text "Add" ]
        , button
            [ type' "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
