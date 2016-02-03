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
	thin start --ssl

lint:
	@echo 'Linting...'
	rubocop
	eslint .
