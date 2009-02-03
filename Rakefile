
require "#{File.expand_path(File.dirname(__FILE__))}/init"

begin
  require 'rubygems'
  require 'app-deploy'

rescue LoadError

  puts "app-deploy not found, automaticly downloading and installing..."

  `git clone git://github.com/godfat/app-deploy.git app-deploy`
  Dir.chdir 'app-deploy'

  sh 'rake clobber'
  sh 'rake gem:package'
  sh 'gem install --local pkg/app-deploy-*.gem --no-ri --no-rdoc'

  puts "Please re-invoke: rake #{ARGV.join(' ')}"
  exit(1)

end

%w[ bones ramaze dm-core do_sqlite3
    dm-timestamps dm-aggregates dm-sweatshop ].each{ |name|
  AppDeploy.dependency_gem :gem => name
}

# for master ramaze
=begin
AppDeploy.dependency_gem :github_user    => 'manveru',
                         :github_project => 'ramaze' do
  sh 'rake gem'
  sh "gem install --local pkg/ramaze-#{`date '+%Y.%m.%d'`}.gem --no-ri --no-rdoc"
end
=end

AppDeploy.dependency_gem :github_user    => 'godfat',
                         :github_project => 'app-deploy',
                         :task_gem       => 'bones'

AppDeploy.dependency_gem :github_user    => 'godfat',
                         :github_project => 'friendly_format',
                         :task_gem       => 'bones'

AppDeploy.dependency_gem :github_user    => 'godfat',
                         :github_project => 'pagify',
                         :task_gem       => 'bones'

namespace :db do
  desc 'setup db, it\'s DESTRUCTIVE!!!'
  task :setup => [:auto_migrate, :import_fixtures]

  task :auto_migrate do
    puts 'this is DESTRUCTIVE!!!'
    require 'model/init'
    DataMapper.auto_migrate!
  end

  task :import_fixtures => [:import_role]

  task :import_role do
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

namespace :app do
  namespace :server do
    [:start, :stop, :restart].each{ |cmd|
      desc "#{cmd} all servers"
      task cmd do
        ENV['config'] = JinRou.expand('config/rack.yaml')
        Rake::Task["app:rack:#{cmd}"].execute
      end
    }
  end
end
