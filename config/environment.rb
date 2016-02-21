# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
 
 $sendgrid = SendGrid::Client.new do |c|
   c.api_key = ENV['SENDGRID_ACCESS_KEY']
 end