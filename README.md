# Zelos invoice - die Personifikation des eifrigen Strebens
Zelos is a **open-source** invoice app for **software engineers** who want control over their generated PDFs, have a nice overview and see beautiful **graphical charts**. It shows the  yearly income, keeps track of **customers** and don't mix things up like I did before when using proprietary software. Experienced developers can continue on the project and customize it to their own needs.

![Zelos invoice dashboard](/app/assets/images/screen1.jpg?raw=true "Zelos invoice dashboard")

## Installation
1. Install gems `bundle install`
2. Copy `config/database.yml.default` to `config/database.yml` and setup environment database variables
3. Copy `config/secrets.yml.default` to `config/secrets.yml` and define app secrets for mail server, repository and capistrano deployment options
4. Prepare rails database and seed example data `bundle exec rake db:migrate db:seed`
5. Install npm dependencies `npm install`
6. Provide all settings at `admin/settings` required for the generated invoice

## Development
`bundle exec rails server`

`gulp bs` start browsersync and watch sass and html

`npm start` watch javascript with webpack

### Time-zone support
Chartkick together with groupdate requires time-zone support
Run this statements in SQL console
https://gist.githubusercontent.com/ankane/1d6b0022173186accbf0/raw/time_zone_support.sql
and this
`SELECT CONVERT_TZ(NOW(), '+00:00', 'Etc/UTC');`
should return the time instead of NULL

https://github.com/ankane/groupdate#for-mysql

Otherwise remove groupdate from gemfile and remove the group_by_month function from entries/index

## Capistrano deployment http://capistranorb.com

run commands with `cap` followed by environment like staging/production
eg: `cap production deploy`

`cap -T` show all capistrano tasks

`cap production "invoke[console]"` invoke rake command on live server

`cap production rails:console` run remote console

## Deployment requirements

bundler must be installed globally on server:
`gem install bundler`

`cap production setup:upload_yml` upload database.yml and secrets.yml to production server

`cap production deploy` for deployment

## l18n
currently there are two languages availble, english and german. Copy one of them to your corresponding language file under `config/locales/yourlang.yml` and set the language key in the settings eg: `en` or `de`
