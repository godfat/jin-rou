
class Turn
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  belongs_to :game

  has n, :messages
end
