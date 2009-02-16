
require 'digest/sha1'

class Player
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  property :name,     String
  property :password, String, :size => 40
  property :salt,     String, :size => 12

  belongs_to :village
  belongs_to :role
  belongs_to :character

  has n, :messages
  has n, :votes

  def say something
    Message.create(:player => self, :name => something)
  end

  def vote day, who
    Vote.create(:day => day, :obj => self, :sbj => who)
  end

  # for user who don't want to create a password itself
  def password_generate
    self.password = rand.to_s[2..-1].to_i.to_s(36)
  end

  def password_check input
    password == password_caculate(input)
  end

  def password= input
    self.salt = rand.to_s.reverse[0, 12]
    attribute_set(:password, password_caculate(input))
    input
  end

  private
  def password_caculate input
    Digest::SHA1.hexdigest( salt[0...salt[0, 1].to_i] + input +
                            salt[    salt[0, 1].to_i..-1] )
  end
end
