install:
	bundle install
	npm install

start:
	thin start --ssl

# TODO make command to deploy to heroku

lint:
	rubocop
	eslint .
