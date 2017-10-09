require_relative('../db/sql_runner')
require_relative('../models/ticket')


class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  # CRUD

  # create
  def save()
    # sql
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    # values
    values = [@name, @funds]
    # sql runner
    results = SqlRunner.run(sql, "save_customer", values)
    # set id
    @id = results[0]['id'].to_i
  end

  # read
  def self.all()
    # sql
    sql = "SELECT * FROM customers;"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_all_customers", values)
    # return
    return results.map {|customer| Customer.new(customer)}
  end

  # update
  def update()
    # sql
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;"
    # values
    values = [@name, @funds, @id]
    # sql runner
    SqlRunner.run(sql, "update_customer", values)
  end

  # delete
  def self.delete_all()
    # sql
    sql = "DELETE FROM customers;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_customers", values)
  end

  def delete()
    # sql
    sql = "DELETE FROM customers WHERE id = $1;"
    # values
    values = [@id]
    # sql runner
    SqlRunner.run(sql, "delete_customer", values)
  end


  # show all customer's tickets
  def booked_films()
    # sql
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1;"
    # values
    values = [@id]
    # sql runner
    results = SqlRunner.run(sql, "get_all_booked_films", values)
    # return
    return results.map {|film| Film.new(film)}
  end

  # count customer tickets
  def number_tickets()
    booked_films().count()
    # alternative sql:
    # # sql
    # sql = "SELECT COUNT(films.id) FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1;"
    # # values
    # values = [@id]
    # # results
    # results = SqlRunner.run(sql, "get_number_tickets", values)
    # # return
    # return results[0]['count'].to_i
  end

  # buy ticket
  def buy_ticket(film)
    @funds -= film.price()
    update()
    ticket = Ticket.new(
      {
        'customer_id' => @id,
        'film_id' => film.id
      }
    )
    ticket.save()
  end

end
