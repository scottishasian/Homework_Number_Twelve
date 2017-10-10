require ( 'pg' )

class Bounties
  attr_accessor :name, :species, :homeworld, :bounty_value
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @homeworld = options['homeworld']
    @bounty_value = options['bounty_value'].to_i
  end

  def save()
    db = PG.connect({
      dbname: 'spacecowboys',
      host: 'localhost'
      })
    sql = "
      INSERT INTO bounty_info (name, species, homeworld, bounty_value)
      VALUES ($1, $2, $3, $4)
      RETURNING *
    "
    values = [@name, @species, @homeworld, @bounty_value]
    db.prepare("save", sql)

    results = db.exec_prepared("save", values)

    @id = results[0]['id'].to_i
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: 'spacecowboys',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounty_info"
    values = []
    db.prepare("all", sql)
    bounties = db.exec_prepared("all", values)
    db.close()

    bounties_as_objects = bounties.map{|bounty| Bounties.new(bounty)}
    return bounties_as_objects
  end

  def self.delete_all()
    db = PG.connect({
      dbname: 'spacecowboys',
      host: 'localhost'
      })
    sql = "DELETE FROM bounty_info"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close
  end

end
