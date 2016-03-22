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

env:
	touch config/application.yml
	echo "ACCESS_KEY: \"A7DE6825FD96CCC79E63C89B55F88\"" >> config/application.yml
	echo "AWS_ACCESS_KEY_ID: \"XXX\"" >> config/application.yml
	echo "AWS_SECRET_ACCESS_KEY: \"XXX\"" >> config/application.yml
	echo "AWS_REGION: \"us-west-2\"" >> config/application.yml
	echo "SENDGRID_ACCESS_KEY: \"XXX\"" >> config/application.yml

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
