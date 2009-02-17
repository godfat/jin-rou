
require 'digest/sha1'

begin
  # if there's no dm-types/enum, use String instead
  require 'dm-types/enum'
rescue LoadError
end

class Player
  include DataMapper::Resource
  property :id, Serial
  property :type, Discriminator
  timestamps :at

  # game property
  begin
    property :status, Enum.new(:alive, :dead), :default => :alive

  rescue NameError
    property :status, String, :default => 'alive'
    def status
      @status.to_sym
    end

  end

  # user property
  property :password, String, :size => 40
  property :salt,     String, :size => 12

  belongs_to :game
  belongs_to :role
  belongs_to :character

  has n, :messages
  has n, :votes

  def say something
    Message.create(:player => self, :name => something)
  end

  def vote turn, who
    Vote.create(:turn => turn, :obj => self, :sbj => who)
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
