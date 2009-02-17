
class Vote
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  belongs_to :turn
  belongs_to :obj, :class_name => 'Player', :child_key => [:obj_id]
  belongs_to :sbj, :class_name => 'Player', :child_key => [:sbj_id]
end
