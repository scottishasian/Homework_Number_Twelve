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

  def delete()
    db = PG.connect({
      dbname: 'spacecowboys',
      host: 'localhost'
      })
    sql = "DELETE FROM bounty_info
          WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def update()
    db = PG.connect({
      dbname: 'spacecowboys',
      host: 'localhost'
      })
    sql = "UPDATE bounty_info
          SET (name, species, homeworld, bounty_value) = ($1, $2, $3, $4)
          WHERE id = $5
          "
    values = [@name, @species, @homeworld, @bounty_value, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  # def self.find(id_number)
  #   db = PG.connect({
  #     dbname: 'spacecowboys',
  #     host: 'localhost'
  #     })
  #   sql = "SELECT * FROM bounty_info
  #         WHERE id = $1"
  #   values = [@id]
  #   db.prepare("find", sql)
  #   find_bounty = db.exec_prepared("find", values)
  #   db.close()
  #
  #   found_bounty = find_bounty.map{|bounty| Bounties.new(bounty)}
  #   return found_bounty
  # end

end
