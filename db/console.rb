require('pry-byebug')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screening')

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
customer1.buy_ticket(film1)

ticket2 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film2.id
  }
)

customer2.buy_ticket(film2)


ticket3 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film3.id
  }
)

customer2.buy_ticket(film3)

ticket4 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film3.id
  }
)

customer1.buy_ticket(film2)


# create screenings

screening1 = Screening.new({
  'film_id' => film1.id,
  'showing' => '19:00',
  'capacity' => 80,
  'available' => 80
  }
)

screening2 = Screening.new({
  'film_id' => film1.id,
  'showing' => '21:00',
  'capacity' => 80,
  'available' => 80
  }
)

screening3 = Screening.new({
  'film_id' => film1.id,
  'showing' => '00:00',
  'capacity' => 80,
  'available' => 80
  }
)

screening4 = Screening.new({
  'film_id' => film2.id,
  'showing' => '19:00',
  'capacity' => 60,
  'available' => 60
  }
)

screening5 = Screening.new({
  'film_id' => film3.id,
  'showing' => '20:00',
  'capacity' => 50,
  'available' => 50
  }
)

screening6 = Screening.new({
  'film_id' => film4.id,
  'showing' => '20:00',
  'capacity' => 50,
  'available' => 50
  }
)

screening7 = Screening.new({
  'film_id' => film4.id,
  'showing' => '20:00',
  'capacity' => 50,
  'available' => 60  # defaults to 50 as per constraint (CHECK) in cinema.sql
  }
)

screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()
screening6.save()

binding.pry
nil
