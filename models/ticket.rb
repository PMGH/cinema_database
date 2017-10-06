require_relative('../db/sql_runner')
require_relative('../models/customer')


class Ticket

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  # CRUD

  # create
  def save()
    # sql
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
    # values
    values = [@customer_id, @film_id]
    # sql runner
    results = SqlRunner.run(sql, "save_ticket", values)
    # set id
    @id = results[0]['id'].to_i
  end

  # read
  def self.all()
    # sql
    sql = "SELECT * FROM tickets;"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_all_tickets", values)
    # return
    return results.map {|ticket| Ticket.new(ticket)}
  end

  # update
  def update()
    # sql
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3;"
    # values
    values = [@customer_id, @film_id, @id]
    # sql runner
    SqlRunner.run(sql, "update_customer", values)
  end

  # delete
  def self.delete_all()
    # sql
    sql = "DELETE FROM tickets;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_tickets", values)
  end

  def delete()
    # sql
    sql = "DELETE FROM tickets WHERE id = $1;"
    # values
    values = [@id]
    # sql runner
    SqlRunner.run(sql, "delete_ticket", values)
  end

end
