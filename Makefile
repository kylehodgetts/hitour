port ?= 3000

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

test:
	rspec
	# Front end test command

lint:
	@echo 'Linting...'
	rubocop
	eslint .
