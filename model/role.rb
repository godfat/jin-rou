
class Role
  include DataMapper::Resource
  property :id, Serial
  property :type, Discriminator
  property :name, String
end

class Villager < Role
end

class Astrologer < Role
end

class Coroner < Role
end

class Guardian < Role
end

class Disciple < Role
end

class Avenger < Role
end

class Werewolf < Role
end

class Tobewolf < Role
end

class HuliJin < Role
end
