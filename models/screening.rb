class Screening

  attr_accessor :film_id, :showing, :capacity, :available
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @showing = options['showing']
    @capacity = options['capacity']
    @available = options['available']
  end

  # CRUD

  # create
  def save()
    # sql
    sql = "INSERT INTO screenings (film_id, showing, capacity, available) VALUES ($1, $2, $3, $4) RETURNING id;"
    # values
    values =[@film_id, @showing, @capacity, @available]
    # sql runner
    results = SqlRunner.run(sql, "save_screening", values)
    # set id
    @id = results[0]['id'].to_i
  end

  # read
  def self.all()
    # sql
    sql = "SELECT * FROM screenings;"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_all_screenings", values)
    # return
    return results.map {|screening| Screening.new(screening)}
  end

  # update
  def update()
    # sql
    sql = "UPDATE screenings SET (film_id, showing, capacity, available) = ($1, $2, $3, $4) WHERE id = $5;"
    # values
    values = [@film_id, @showing, @capacity, @available, @id]
    # sql runner
    SqlRunner.run(sql, "update_screening", values)
  end

  # delete
  def self.delete_all()
    # sql
    sql = "DELETE FROM screenings;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_screenings", values)
  end

  def delete()
    # sql
    sql = "DELETE FROM screenings WHERE id = $1;"
    # values
    values = [@id]
    # sql runner
    SqlRunner.run(sql, "delete_screening", values)
  end

  # most popular
  def fullest()
    # sql
    sql = "SELECT MAX()"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_fullest_screening", values)
    # return
    return results.map {|screening| Screening.new(screening)}
  end

end
