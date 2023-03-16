# Sinaptia CRM

CRM made with Ruby on Rails and Tailwind CSS

## Setup instructions

Clone this repository and install dependencies

```ruby
bundle install
```

Set up a postgresql database, db configuration can be found in config/database.yml, and then run migrations with:

```ruby
rails db:migrate
```

This projects works with the 'standardrb' gem, you can run standard with:

```ruby
yarn lint
```

and fix errors with:

```ruby
yarn lint:fix
```
