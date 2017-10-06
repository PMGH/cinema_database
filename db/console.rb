require('pry-byebug')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

# add customers
customer1 = Customer.new(
  {
    'name' => 'David',
    'funds' => 45
  }
)

customer2 = Customer.new(
  {
    'name' => 'Alex',
    'funds' => 50
  }
)

customer1.save()
customer2.save()


# add films
film1 = Film.new(
  {
    'title' => 'Road Runner',
    'price' => 7
  }
)

film2 = Film.new(
  {
    'title' => '300',
    'price' => 5
  }
)

film3 = Film.new(
  {
    'title' => 'The Beach',
    'price' => 4
  }
)

film4 = Film.new(
  {
    'title' => 'The Girl With The Dragon Tattoo',
    'price' => 4
  }
)

film1.save()
film2.save()
film3.save()
film4.save()


# customers assigned tickets
ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film1.id
  }
)

# pay for ticket (and update db)
customer1.buy_ticket(film1.id)

ticket2 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film2.id
  }
)

customer2.buy_ticket(film2.id)


ticket3 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film3.id
  }
)

customer2.buy_ticket(film3.id)

ticket4 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film3.id
  }
)

customer1.buy_ticket(film2.id)


ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
