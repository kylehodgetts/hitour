port ?= 3000
name ?= component

install:
	bundle install
	npm install
	@echo 'Installation successful!'

setup:
	bundle exec rake db:setup
	bundle exec rake db:migrate
	@echo 'Setup successful!'

start:
	@echo 'Server starting...'
	thin start --ssl -p ${port}

comp:
	rails generate react:component ${name} --es6

test:
	rspec

lint:
	@echo 'Linting...'
	rubocop
	eslint .
