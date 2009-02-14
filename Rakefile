
require "#{File.expand_path(File.dirname(__FILE__))}/init"

task :default do
  Rake.application.options.show_task_pattern = /./
  Rake.application.display_tasks_and_comments
end

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

require 'task/db'
require 'task/log'

%w[ bones ramaze dm-core ya2yaml
    dm-timestamps dm-aggregates ].each{ |name|
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
  task :setup => [:auto_migrate, :import_fixture]

  task :auto_migrate do
    JinRou.db_auto_migrate
  end

  task :import_fixture do
    JinRou.db_import_fixture
  end

  task :import_role do
    JinRou.db_import_role
  end
end

namespace :log do
  desc 'truncate logs'
  task :clear do
    JinRou.log_clear
  end

  desc 'gzip logs'
  task :gzip do
    JinRou.log_gzip
  end
end

namespace :console do
  desc 'model console for you'
  task :model do
    require 'model/init'
    require 'irb'
    ARGV.clear
    IRB.start
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
