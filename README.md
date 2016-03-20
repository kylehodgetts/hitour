# HiTour Content Management System

Build Status: ![Circle CI](https://circleci.com/gh/KyleHodgetts/project-run-cms/tree/master.svg?style=svg&circle-token=989dd912291e5b69390dca32f8add4930208ba9f)

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

To log into the CMS on a local server
  * Email: `dev@mail.com`
  * Password: `password`
  * Note: This will not work in production!

## Contribution
  * Conventions
    * We are using Airbnb's style guides for both [Ruby](https://github.com/airbnb/ruby) and [Javascript](https://github.com/airbnb/javascript)
    * `make lint` to check for offences
  * Open pull request with name of feature
    * Feature must have full set of passing tests and marked with `Ready for Review` tag when ready to be tested
    * Tests are written using the [RSpec](http://rspec.info/) testing framework
    * Other member of team to test feature and merged when functionality has been tested.
  * Feature branch must be a passing build on [CircleCi](https://circleci.com/gh/KyleHodgetts/project-run-cms)
