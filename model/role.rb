
class Role
  include DataMapper::Resource
  property :id, Serial
  property :type, Discriminator
  property :name, String
end

# side with Rabbit
class Rabbit < Role
end

class Owl < Role
end

class Fly < Role
end

class Dog < Role
end

class Sparrow < Role
end

class Viper < Role
end

# side with Wolf
class Wolf < Role
end

class Bat < Role
end

# side with Fox
class Fox < Role
end
