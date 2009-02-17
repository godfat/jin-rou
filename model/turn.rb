
class Turn
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  # 0    => waiting room
  # odd  => night
  # even => day
  property :index, Integer

  belongs_to :game

  has n, :messages
end
