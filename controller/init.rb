# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers

class Controller < Ramaze::Controller
  layout '/layout'
  helper :xhtml
  engine :Ezamar
end

# Here go your requires for subclasses of Controller:
require 'controller/main'
