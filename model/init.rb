# Here goes your database connection and options:

# Here go your requires for models:
# require 'model/user'

require 'rubygems'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, JinRou.yaml_load('config/database.yaml')['uri'])

Dir.glob(File.dirname(__FILE__) + "/*.rb").map{ |file|
  # snip base dir and file ext
  file = file[ (file =~ %r{model/})..-4 ]

  next if file == 'model/init'
  require file

  Object.const_get(Extlib::Inflection.classify(File.basename(file)))

}.compact.each{ |model|

  model.properties.each{ |property|
    # property default no nil
    property.instance_variable_set('@nullable', false)

    # skip key
    next if property.key? || property.default

    # number default 0
    property.instance_variable_set('@default', 0) if
      [Integer, Float].member?(property.primitive)

    # string default empty
    property.instance_variable_set('@default', '') if
      property.primitive == String

    # date/time default 0
    property.instance_variable_set '@default', DateTime.new(0) if
      property.primitive == DateTime
  }

  model.many_to_one_relationships.each{ |relationship|
    # foreign key default index
    relationship.child_key.each{ |property|
      property.instance_variable_set('@index', true) unless property.serial?
    }
  }
}
