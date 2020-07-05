# Sky.rb ![specs](https://github.com/rhannequin/skyrb/workflows/CI/badge.svg)

## Context

Rails-based API providing data about bright stars, contellations, Messier and NGC objects, and Solar system major bodies.

[_Currently in active development_]

## Requirements

* Ruby 2.7.1
* Rails 6
* PostgreSQL ~11

## Initialization

```
$ bundle e rails db:prepare
```

```rb
# bundle e rails c

Sky::Constellations.new.load!
Sky::HygDatabase.new.load!
```

## CI

[Project's Github Actions](https://github.com/rhannequin/skyrb/actions)

## Test

```sh
$ bundle e rails db:prepare
$ bundle e rspec
```
