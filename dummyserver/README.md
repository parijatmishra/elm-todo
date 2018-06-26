# elm-todo / backend

A dummy backend server for our todo list front-end, using [json-server](https://github.com/typicode/json-server).


## Building it

You will [NodeJs](http://nodejs.org/), [npm](https://www.npmjs.com/), and [yarn](https://yarnpkg.com/lang/en/) installed.

Nothing to build. Just install the packages:

```
npm install -g yarn # If you don't have yarn installed
yarn install
```

## Running it

```
yarn server
```

Now you can make API calls against it at `http://localhost:4000/api`

### Listing all todos

```
$ curl http://localhost:4000/api/todos
[
  {
    "id": "1",
    "title": "First todo",
    "complete": false
  },
  {
    "id": "2",
    "title": "First todo",
    "complete": true
  },
  {
    "id": "3",
    "title": "Third todo",
    "complete": false
  }
]
```

### Listing a single TODO

```
$ curl http://localhost:4000/api/todos/1
{
  "id": "1",
  "title": "First todo",
  "complete": false
}
```

### Adding a TODO, specifying a unique ID

```
$ curl -X POST --header 'Content-type: application/json' --data-binary '{"id": 4, "title":"Another todo", "complete":true}' http://localhost:4000/api/todos/
{
  "id": 4,
  "title": "Another todo",
  "complete": true
}
```

If the `id` is already taken, the server will return an error and not save the todo.

### Addint a TODO, letting the server specify an ID


It is perhaps best to not specify the `id` field and let the server generate one.

```
$ curl -X POST --header 'Content-type: application/json' --data-binary '{"title":"Yet another todo", "complete":true}' http://localhost:4000/api/todos/
{
  "title": "Yet another todo",
  "complete": true,
  "id": 5
}
```

Here, the server generated the value `5` for the field `id`.


### Deleting a TODO

If you know the `id` of a todo, you can delete it:

```
$ curl -X DELETE http://localhost:4000/api/todos/4
{}
$  curl http://localhost:4000/todos
[
  {
    "id": "1",
    "title": "First todo",
    "complete": false
  },
  {
    "id": "2",
    "title": "First todo",
    "complete": true
  },
  {
    "id": "3",
    "title": "Third todo",
    "complete": false
  },
  {
    "title": "Yet another todo",
    "complete": true,
    "id": 5
  }
]
```

Now the todo `4` is no longer present in the output.

### Updating a TODO

You can change any field of a todo (except its `id`):

```
$ curl -X PUT -H "Content-type: application/json" --data-binary '{"title": "Changing a todo", "complete": false}' http://localhost:4000/api/todos/5
{
  "title": "Changing a todo",
  "complete": false,
  "id": 5
}
```
