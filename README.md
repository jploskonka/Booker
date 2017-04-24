# Bookmarks manager
[![Build Status](https://travis-ci.org/jploskonka/Booker.svg?branch=master)](https://travis-ci.org/jploskonka/Booker)
Simple application to store bookmarks to your favourite web pages.

## Live version
Application is deployed to heroku, check it out
[here](http://bookmanon.herokuapp.com) (it uses free Heroku trial so first
request may be little bit slow).

## Development
Clone the repository:
```
git clone git@github.com:jploskonka/Booker.git
```

Install dependencies:
```
$ cd Booker # go into cloned directory
$ bundle install
```

Update `config/database.yml` with correct values if necessary and setup database:
```
$ bundle exec rake db:setup
```
This will create database for you and create tables based on `db/schema.rb`
file.

Finally run the development server:
```
$ bundle exec rails s
```

Now just open [`http://localhost:3000`](http://localhost:3000) in your favourite browser, happy coding!

## Testing
I'm using Rspec and Capybara as testing tools. To run tests just use:
```
bundle exec rspec
```

There's also TravisCI configured for repository, you can check it out
[here](https://travis-ci.org/jploskonka/Booker).

## Dependencies
Ruby v2.4.0 (Suggested way to install it is to use [rbenv](https://github.com/rbenv/rbenv))
[Postgresql](https://www.postgresql.org/download/)
qt5+ (for capybara-webkit, more info
[here](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit))
