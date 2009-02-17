
class Game
  include DataMapper::Resource
  property :id, Serial
  timestamps :at

  property :name, String

  has n, :players
  has n, :turns

  def dispatch_player
    chars   = Character.all.shuffle
    roles   =      Role.all.map{ |role|
                     [role] * case role
                                when Villager;   10
                                when Astrologer;  1
                                when Coroner;     1
                                when Guardian;    1
                                when Disciple;    2
                                when Avenger;     1
                                when Werewolf;    4
                                when Tobewolf;    1
                                when HuliJin;     1
                              end
                   }.flatten.shuffle

    players.each{ |pl|
      pl.update_attributes( :character => chars.pop,
                                 :role => roles.pop  )
    }

  end
end
