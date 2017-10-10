require ( 'pg' )

class Bounties
  attr_accessor :name, :species, :homeworld, :bounty_value
  attr_reader :id

  def initialize
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @homeworld = options['homeworld']
    @bouty_value = options['bouty_value'].to_i
  end

end
