
class Game
  include DataMapper::Resource
  property :id, Serial
  property :deleted_at, ParanoidDateTime
  timestamps :at

  property :name, String

  has 1, :wizard
  has n, :players
  has n, :turns

  def kick pid_or_player
     pid = pid_or_player.kind_of?(Integer) ? pid_or_player : pid_or_player.id

    if p = players.get(pid)
      p.destroy
      # reload to see if we kick the wizard
      reload
      pickup_wizard unless wizard
    end
  end

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

  private
  def pickup_wizard
    picked = players.first(:offset => rand(players.size).to_i)
    if picked
      # upgrade it to wizard
      picked.update_attributes(:type => Wizard)
    else
      # no one left for this game
      destroy
    end
  end
end
