# README

Ruby version used: v3.1.0
Rails version used: v7.0.8
SQLite is used as database

## Setup

```bash
bundle
rails db:create db:migrate db:seed
```

Two products with reviews will be created by `db:seed` command.
A feature flag will be created named `standalone_reviews` with value `true`. Meaning by default the product reviews are available only under /products/:id/review endpoint

## Run app

```bash
rails server
```

## Run tests

```bash
rails test
```

## Managing feature flags

* Feature flags management is implemented with rake tasks
* Feature flag name must be unique
* Feature flag possible values are (boolean) `true` or `false`

### Adding feature flag

```bash
rake "feature_flags:add[cool_feature, true]"
```

Second argument is an optional boolean argument that will set the value of created feature flag. It is set to `false` if not provided.

### Checking the current value of feature flag

```bash
rake "feature_flags:get[cool_feature]"
```

### Setting value of feature flag

```bash
rake "feature_flags:set[cool_feature, false]"
```
