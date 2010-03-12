# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = {
    :location => '/usr/sbin/sendmail',
    :arguments => '-i -t'
  }
  config.gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
  config.gem 'authlogic'
  config.gem 'robinsp-sortable_element_for_nested_set', :lib => 'sortable_element_for_nested_set', :source => 'http://gems.github.com'
  config.gem 'maruku'
  config.time_zone = 'UTC'
end
