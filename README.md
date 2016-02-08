# HiTour Content Management System

## TODO
- [ ] Set up front end testing

### Team Members
* Kyle
* Dominik
* Ana
* Charlie
* Adam
* Phileas
* Tahmidul
* Ben

## Setup and Run
To install dependencies: `make install`

To setup:
  * Ensure you have [Postgresql](http://www.postgresql.org/download/) installed and running locally
  * `make setup`

To make new React.js component:
  * Make new component `make comp name=[COMPONENT_NAME]`

To start server on port 3000: `make start`
To start server on port of your choosing: `make start port=[PORTNUM]`

## Contribution
  * Our style [guide](https://github.com/bbatsov/ruby-style-guide) for Ruby
    * `make lint` to check for offences
  * Open pull request with name of feature
    * Feature must have full set of passing tests and marked with `Ready` tag when ready to be tested
    * Other member of team to test feature and merged when functionality has been tested.
  * Feature branch must be a passing build on [CircleCi](https://circleci.com/gh/KyleHodgetts/project-run-cms)

### Production Pipeline
```
Feature dev branch >> Staging >> Production
```
