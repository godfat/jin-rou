
require 'rubygems'
require 'ramaze'

# Add directory start.rb is in to the load path, so you can run the app from
# any other working path
# $LOAD_PATH.unshift(__DIR__)

# this would take care of load path without requiring ramaze,
# plus other utility like relative file reading.
require "#{File.expand_path(File.dirname(__FILE__))}/init"

# Initialize controllers and models
require 'controller/init'
require 'model/init'

Ramaze.start :adapter => :webrick, :port => 7000
