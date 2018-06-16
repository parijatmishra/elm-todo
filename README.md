# elm-todo
A simple TODO app written in Elm, bundling/build using webpack, and a test server using json-server.

# Building

## Installing pre-requisites

This project uses [yarn]
Install:
  - [nodejs](https://nodejs.org/en/)
  - [npm](https://www.npmjs.com/)
  - [yarn](https://yarnpkg.com/lang/en/)

For e.g., on Ubuntu 18.04:

```
$ sudo apt-get install -y nodejs
$ sudo apt-get install -y npm
# Ubuntu's npm may not be latest; upgrade
$ sudo npm install -g npm
# Remove npm installed by apt-get
$ sudo apt-get remove --purge npm
# Create symlink to new npm from /usr/bin
$ sudo ln -sfn /usr/local/bin/npm /usr/bin/npm
$ sudo npm install -g yarn
````

