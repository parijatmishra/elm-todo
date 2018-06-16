# elm-todo
A simple TODO app written in Elm, bundling/build using webpack, and a test server using json-server.

# Building

## Installing pre-requisites

This project uses [yarn](https://yarnpkg.com/lang/en/) to install JavaScript libraries and build tools.

Ensure the following are installed on your development/build system:

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
```

## Install JavaScript libraries and build tools

This project uses [webpack](https://webpack.js.org/) to compile the JavaScript and other assets into a distributable form.  It also uses some CSS and JS libraries.  Both are described in `package.json`, and are installed like this:


```
$ yarn install
```

## Run locally for development

The project uses webpack's ability to run a development web server to serve up HTML, JS and other static assets while developing.  Webpack configuration is in the file `webpack.config.js`.

To make it easy to execute webpack, a couple of yarn commands are defined in `package.json`, in the `scripts' entry.

To start a development web server, run:

```
$ yarn runclient
```

This call webpack to start a development server on port 3000. You will be now be able to see the project in your browser at [http://localhost:3000/].  The content should be like this:

>    Hi there and greetings!
>
>    # Hello, World!

The text "Hi there and greetings!" is inserted by JavaScript dynamically.  If it does not appear, the asset bundling feature of webpack is not working, and you should check `webpack.config.js` and `package.json`.

*Note: serving up the files in `src/` with a simple web server (e.g., via `python -m http.server`) is not sufficient as the HTML refers to javascript that must be first created.  You must use webpack to assemble the assets, and `yarn build` and `yarn runclient` do that.*

## Create distribution

To create a distributation bundle, run:

```
$ yarn build
```

The directory `dist/` will contain the output files, which can be deployed to a web server as static assets.

*Note: this directory contains files in their final form, with no server side processing required.  You should be able to serve them with a static web server like `python -m http.server` if you want to check.*
