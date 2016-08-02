Sample MyApp
=============

A web app that accepts country name and returns top artists.

##TODO:
* Add stub and mock thirdparty request
* Configure rack
* Add templating for views
* Move helper to its own directory
* Fix Guardfile for easier TDD


Usage:

```
copy .env.example .env
$ bundle install
$ bundle exec dotenv ruby app.rb
```


Run tests:

```
bundle exec rake test
```
