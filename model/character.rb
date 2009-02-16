
class Character
  include DataMapper::Resource
  property :id, Serial

  property :name, String
  property :color, String
  property :avatar, String # URI
end
