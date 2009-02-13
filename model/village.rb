
class Village
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  property :name, String

  has n, :players
  has n, :days
end
