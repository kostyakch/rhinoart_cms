# Rhinoart

Rhinoart is a admin engine system. This a CMS backend

## Installation:

``` ruby
# Gemfile for Rails 4
gem 'rhinoart', git: 'https://github.com/kostyakch/rhinoart_cms.git'
```

## Basic rhinoart use

### Add in Your Gemfile line like this:
``` ruby
gem 'rhinoart', github: 'kostyakch/rhinoart_cms'
```

After it:

``` ruby
$ rails g rhinoart:install

#and
$ rake db:populate #if need
```
Now You cat login: http://127.0.0.1:3000/admin
login: admin@test.com
password: admin

You may need to change line in Your app config/environments/development.rb
``` ruby
config.eager_load = true
```
