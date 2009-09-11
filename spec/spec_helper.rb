require 'rubygems'
require 'spork'
ENV["RAILS_ENV"] = 'test'

# at first run
Spork.prefork do
  require File.dirname(__FILE__) + "/../config/environment"

  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  require 'spec/autorun'
  require 'spec/rails'

  Spec::Runner.configure do |config|
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
  end
end

# at every, but first run
Spork.each_run do
  
end

# at every run ...
