# Here goes your database connection and options:

# Here go your requires for models:
# require 'model/user'

require 'rubygems'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, JinRou.yaml_load('config/database.yaml')['uri'])

Dir.glob(File.dirname(__FILE__) + "/*.rb").each{ |file|
  # snip base dir and file ext
  file = file[ (file =~ %r{model/})..-1 ][0..-4]

  next if file == 'model/init'
  require file
}
