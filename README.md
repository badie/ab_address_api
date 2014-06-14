## Simple Address API

A basic sinatra app that describes an api to create, read, update, delete a user and list all contacts for a user.


### Installation
- Clone project
- run `bundle install` to install the necessary gems
- run `rackup` to start the sinatra server. App should be up and running at [http://localhost:9292](http://localhost:9292)

### Run app locally
- `cd` into the project directory.
- run `brew install mongo` if mongo is not currently installed on your machine.
- run `rackup` to run start at [http://localhost:9292](http://localhost:9292).

### Deploy to heroku
- Create account/login to heroku.
- Create an app on heroku.
- `cd` into the project directory.
- run `git remote add heroku <heroku-git-path>`.
- run `heroku addons:add mongohq` to setup a Mongo Addon.
- run `git push heroku master`.
- app should be up and running on heroku.
