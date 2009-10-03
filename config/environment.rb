RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "grosser-rpx_now", :lib => 'rpx_now', :version => '0.5.9', :source=>"http://gems.github.com"
  config.gem "man_parser", :version => '0.1.3', :source=>"http://gemcutter.org"

  config.time_zone = 'UTC'

  # initialize plugins/gems
  config.after_initialize do
    # load everything from lib/ext
    Dir["#{RAILS_ROOT}/lib/ext/**/*.rb"].each{|file| require file.sub('.rb','') }

    RPXNow.api_key = 'd32a482b8a63a6e94a4e7c8422b78047392c6ef5'
  end
end



