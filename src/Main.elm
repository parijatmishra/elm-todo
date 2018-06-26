module Main exposing (..)

import Html exposing (Html, div, span, input, text, button, i)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, classList, placeholder, type_, checked, disabled, value, title, style)
import Http
import RemoteData exposing (WebData)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline

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
    { todos : (WebData (List Todo))
    , newTodoText: String
    }


type alias Todo =
    { id: Int
    , title : String
    , complete : Bool
    }


--- MESSAGES


type Msg =
    OnTodosFetched (WebData (List Todo))
    | ChangeText String
    | AddTodo
    | ToggleTodo Int
    | DeleteTodo Int


--- COMMAND helpers
baseUrl: String
baseUrl = "http://localhost:4000/api"
fetchTodosUrl: String
fetchTodosUrl = baseUrl ++ "/todos"


todosDecoder : Decode.Decoder (List Todo)
todosDecoder = Decode.list todoDecoder

todoDecoder : Decode.Decoder Todo
todoDecoder = Pipeline.decode Todo
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "title" Decode.string
        |> Pipeline.required "complete" Decode.bool

fetchTodos : Cmd Msg
fetchTodos =
    Http.get fetchTodosUrl todosDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnTodosFetched


--- INIT

init : ( Model, Cmd Msg )
init =
    ( {todos = RemoteData.Loading, newTodoText = ""}, fetchTodos )


--- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeText newText ->
            ( {model | newTodoText = newText}, Cmd.none )
        AddTodo ->
            let
                newTodo = { title = model.newTodoText, complete = False }
            in
                ( { model | newTodoText = "" }, Cmd.none )
        ToggleTodo id ->
            let
                f todo =
                    if id == todo.id
                    then { todo | complete = not todo.complete }
                    else todo
                todos = model.todos
                    |> RemoteData.map (List.map f)
            in
                ({ model | todos = todos }, Cmd.none )
        DeleteTodo id ->
            let
                todos =  model.todos
                    |> RemoteData.map (List.filter (\t -> t.id /= id))
            in
                ({ model | todos = todos }, Cmd.none )
        OnTodosFetched todos ->
            ( {model | todos = todos }, Cmd.none)

--- VIEW


view : Model -> Html Msg
view model =
    maybeTodos model

maybeTodos : Model -> Html Msg
maybeTodos model =
    case model.todos of
        RemoteData.NotAsked ->
            text "Initialising..."
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Failure err ->
            text <| "Error loading todos: " ++ (toString err)
        RemoteData.Success todos ->
            todoPage model.newTodoText todos

todoPage : String -> List Todo -> Html Msg
todoPage newTodoText todos =
        Html.div []
            [ Html.h1 [] [ Html.h1 [] [ Html.text "Todos" ] ]
            , newTodoForm newTodoText
            , viewTodoList todos
            ]

viewTodoList : List Todo -> Html Msg
viewTodoList todos =
    div [] (List.map viewTodoItem todos)

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
