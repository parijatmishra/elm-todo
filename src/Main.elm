module Main exposing (..)

import Html exposing (Html, div, span, input, text, button, i)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, classList, placeholder, type_, checked, disabled, value, title, style)

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
    , newTodoText: String
    , nextId: Int
    }


type alias Todo =
    { id: Int
    , title : String
    , complete : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


initModel : Model
initModel =
    { todos =
        [ { id = 1
          , title = "Add checkbox"
          , complete = True
          }
        , { id = 2
          , title = "Add form"
          , complete = True
          }
        , { id = 3
          , title = "Handle Submit"
          , complete = False
          }
        ]
    , newTodoText = ""
    , nextId = 4
    }



--- MESSAGES


type Msg =
    ChangeText String
    | AddTodo
    | ToggleTodo Int
    | DeleteTodo Int

--- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeText newText ->
            ( {model | newTodoText = newText}, Cmd.none )
        AddTodo ->
            let newTodo = { id = model.nextId, title = model.newTodoText, complete = False }
                todos = newTodo :: model.todos
                nextId = model.nextId + 1
            in
                ( { model | todos = todos, newTodoText = "", nextId = nextId }, Cmd.none )
        ToggleTodo id ->
            let
                f todo =
                    if id == todo.id
                    then { todo | complete = not todo.complete }
                    else todo
                todos = List.map f model.todos
            in
                ({ model | todos = todos }, Cmd.none )
        DeleteTodo id ->
            let
                todos = List.filter (\t -> t.id /= id) model.todos
            in
                ({ model | todos = todos }, Cmd.none )

--- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.h1 [] [ Html.text "Todos" ] ]
        , newTodoForm model.newTodoText
        , viewTodoList model
        ]

viewTodoList : Model -> Html Msg
viewTodoList model =
    div [] (List.map viewTodoItem model.todos)

viewTodoItem : Todo -> Html Msg
viewTodoItem todo =
    div [ class "clearfix max-width-3 m1 p1 border rounded"]
        [ div   [ class "col col-10" ]
                [ span  [ class <| todoItemBassClass todo ]
                        [ text todo.title ]
                ]
        , div   [ class "col col-1 center" ]
                [ input [ type_ "checkbox", checked todo.complete, onClick (ToggleTodo todo.id) ]
                        []
                ]
        , div   [ class "col col-1 center" ]
                [ button    [ onClick (DeleteTodo todo.id), title "Delete" ]
                            [ i [ class "fa fa-trash" ] []]
                ]
        ]

todoItemBassClass : Todo -> String
todoItemBassClass todo =
    if todo.complete
    then "gray"
    else "bold"

newTodoForm : String -> Html Msg
newTodoForm todoText =
    div [ class "clearfix max-width-3 m1 p1 border rounded"]
        [ div   [ class "col col-10" ]
                [ input [ type_ "text"
                        , placeholder "Add new todo"
                        , class "block col-12 mb1 field"
                        , onInput ChangeText
                        , value todoText
                        ]
                        []
                ]
        , div   [ class "col col-2 center"]
                [ button    [ onClick AddTodo, class "btn bold white bg-green" ]
                            [ i [ class "fa fa-save mr1" ] []
                            , text "Add"
                            ]
                ]
        ]

--- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
