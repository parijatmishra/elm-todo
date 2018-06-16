module Main exposing (..)

import Html exposing (Html, div, h1, text)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


--- MODEL
type alias Model =
    String

init : (Model, Cmd Msg)
init = ("Stranger", Cmd.none)

--- MESSAGES
type Msg =
    NoOp

--- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
    
--- VIEW

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text <| "Hello, " ++ model ]
        ]

--- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none