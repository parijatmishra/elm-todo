module Main exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr


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
    { todos : List Todo
    }


type alias Todo =
    { title : String
    , complete : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


initModel : Model
initModel =
    { todos =
        [ { title = "Add checkbox"
          , complete = True
          }
        , { title = "Add form"
          , complete = True
          }
        , { title = "Handle Submit"
          , complete = False
          }
        ]
    }



--- MESSAGES


type Msg
    = NoOp



--- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



--- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.h1 [] [ Html.text "Todos" ] ]
        , Html.ul [] (List.map viewTodo model.todos)
        , Html.h2 [] [ Html.text "Add new" ]
        , Html.textarea [ Attr.cols 80, Attr.rows 5 ] []
        , Html.button [] [ Html.text "Add" ]
        ]


viewTodo : Todo -> Html Msg
viewTodo todo =
    Html.li [] [ Html.input [ Attr.type_ "checkbox", Attr.checked todo.complete ] []
               , Html.text todo.title ]



--- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
