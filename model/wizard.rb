
require 'model/player'

class Wizard < Player

  def kick player
    game.kick(player)
  end

end
