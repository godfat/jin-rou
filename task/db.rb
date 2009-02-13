
module JinRou
  module_function
  def db_auto_migrate
    puts 'this is DESTRUCTIVE!!!'
    require 'model/init'
    DataMapper.auto_migrate!
  end

  def db_import_fixture
    db_import_role
  end

  def db_import_role
    require 'dm-sweatshop'
    require 'model/init'
    require 'yaml'

    locale = JinRou.yaml_load('config/setting.yaml')['locale']

    JinRou.yaml_load("locale/#{locale}.yaml")['Role'].each{ |role_name|
      role, name = role_name
      model = Object.const_get(role)

      model.fixture do
        {:name => name}
      end

      model.generate
    }
  end
end
