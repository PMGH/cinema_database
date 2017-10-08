require_relative('../db/sql_runner')


class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  # CRUD

  # create
  def save()
    # sql
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
    # values
    values = [@title, @price]
    # sql runner
    results = SqlRunner.run(sql, "save_film", values)
    # set id
    @id = results[0]['id'].to_i
  end

  # read
  def self.all()
    # sql
    sql = "SELECT * FROM films;"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_all_films", values)
    # return
    return results.map {|film| Film.new(film)}
  end

  # update
  def update()
    # sql
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;"
    # values
    values = [@title, @price, @id]
    # sql runner
    SqlRunner.run(sql,"update_film", values)
  end

  # delete
  def self.delete_all()
    # sql
    sql = "DELETE FROM films;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_films", values)
  end

  def delete()
    # sql
    sql = "DELETE FROM films WHERE id = $1;"
    # values
    values = [@id]
    # sql runner
    SqlRunner.run(sql, "delete_film", values)
  end


  # get all customers that have tickets for a specific film
  def customers()
    # sql
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;"
    # values
    values = [@id]
    # sql runner
    results = SqlRunner.run(sql, "get_all_customers", values)
    # return
    return results.map {|customer| Customer.new(customer)}
  end

  # get the number of customers who have tickets for a specific film
  def number_customers()
    customers().count()
    # alternative sql:
    # # sql
    # sql = "SELECT COUNT(customers.id) FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;"
    # # values
    # values = [@id]
    # # sql runner
    # results = SqlRunner.run(sql, "get_number_customers", values)
    # # return
    # return results[0]['count'].to_i
  end

  # get film screenings
  def screenings()
    # sql
    sql = "SELECT screenings.* FROM screenings INNER JOIN films ON screenings.film_id = films.id WHERE film_id = $1;"
    # values
    values = [@id]
    # sql runner
    results = SqlRunner.run(sql, "get_all_showings", values)
    # return
    return results.map {|screening| Screening.new(screening)}
  end

end
