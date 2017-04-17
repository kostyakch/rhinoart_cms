# Rhinoart

Rhinoart is a admin engine system. This a CMS backend

## Installation:

``` ruby
# Gemfile for Rails 4
gem 'rhinoart', github: 'kostyakch/rhinoart_cms'
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
Now You cat login: http://localhost:3000/admin
login: admin@test.com
password: admin

