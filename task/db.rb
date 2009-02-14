
module JinRou
  module_function
  def db_auto_migrate
    puts 'this is DESTRUCTIVE!!!'
    require 'model/init'
    DataMapper.auto_migrate!
  end

  def db_import_fixture
    db_import_role
    db_import_character
  end

  def db_import_role
    each_locale_data('Role'){ |data|
      role, name = data.first
      Object.const_get(role).create(:name => name)
    }
  end

  def db_import_character
    each_locale_data('Character'){ |data|
      Character.create(data)
    }
  end

  def each_locale_data klass
    require 'model/init'
    require 'yaml'

    locale = JinRou.yaml_load('config/setting.yaml')['locale']
    JinRou.yaml_load("locale/#{locale}.yaml")[klass].each{ |data|
      yield(data)
    }
  end
end
