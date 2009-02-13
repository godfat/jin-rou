
require 'rubygems'
require 'ramaze'

# Add directory start.rb is in to the load path, so you can run the app from
# any other working path
# $LOAD_PATH.unshift(__DIR__)

# this would take care of load path without requiring ramaze,
# plus other utility like relative file reading.
require "#{File.expand_path(File.dirname(__FILE__))}/init"

# require YAML based localization
require 'ramaze/tool/localize'

# Activate localization
# Setup localization options
class Ramaze::Tool::Localize
  Ramaze::Dispatcher::Action::FILTER << self

  trait :mapping => { /^en/ => 'en_US', /^zh/ => 'zh_TW' }

  trait :default_language => 'en_US',
        :languages => %w[ en_US zh_TW ],
        :file => lambda{ |locale| JinRou.expand("locale/#{locale}.yaml") }
  # alternative, problematic if you want to run from another pwd.
  # :file => "locale/%s.yaml"
end

# Initialize controllers and models
require 'controller/init'
require 'model/init'

Ramaze.start
