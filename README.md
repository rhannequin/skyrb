# Sky.rb ![specs](https://github.com/rhannequin/skyrb/workflows/CI/badge.svg)

## Context

Rails-based API providing data about bright stars, contellations, Messier and NGC objects, and Solar system major bodies.

## Sources

- HYG Database `vendor/hygdata_v3.csv` comes from [astronexus/HYG-Database](https://github.com/astronexus/HYG-Database)
- Constellation star mapping `vendor/constellations/constellationships.dat` comes from [Stellarium/stellarium](https://github.com/Stellarium/stellarium)
- NGC `vendor/ngc.csv` comes from [mattiaverga/OpenNGC](https://github.com/mattiaverga/OpenNGC)

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

Sky::Constellations.new.load!  # Loads constellations
Sky::HygDatabase.new.load!     # Loads stars from HYG database
Sky::Asterisms.new.load!       # Loads constellation asterisms
Sky::Ngc::ProcessData.process! # Processes OpenNGC data source to clean it
Sky::Ngc::Import.new.load!     # Imports dark sky objects from OpenNGC
```

## CI

[Project's Github Actions](https://github.com/rhannequin/skyrb/actions)

## Test

```sh
$ bundle e rails db:prepare
$ bundle e rspec
```
