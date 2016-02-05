# Appolice Server

This is the server application to appolice server. It holds the admin area,
the website and the RESTAPIs for the application.

## The stack we are using are:
  - CoffeeScript.
  - Express as the backend.
  - CouchDB as our database with nano.
  - RiotJS as the front-end.
  - Testing with jsVerify and Mocha.

## Installation
  1. MongoDB server: `sudo apt-get install mongodb`
  2. Appolice libraries: `sudo apt-get install build-essential`

It is possible that some more requirements are missing. So install
until everything is properly running.

## Running on dev
  1. do: `npm install`
  2. then run `forever start -c "npm run-script startdev" .`
