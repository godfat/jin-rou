
class Day
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  belongs_to :village

  has n, :messages
end
