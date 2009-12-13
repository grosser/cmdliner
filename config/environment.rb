RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "rpx_now", :version => '0.6.11'
  config.gem "man_parser", :version => '0.1.3'
  config.gem "will_paginate", :version => '>=2'

  config.time_zone = 'UTC'

  # initialize plugins/gems
  config.after_initialize do
    # load everything from lib/ext
    Dir["#{RAILS_ROOT}/lib/ext/**/*.rb"].each{|file| require file.sub('.rb','') }

    RPXNow.api_key = 'd32a482b8a63a6e94a4e7c8422b78047392c6ef5'
  end
end



