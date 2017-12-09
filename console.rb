require_relative ('models/customer')
require_relative ('models/film')
require_relative ('models/ticket')

require ('pry-byebug')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({ 'name' => 'David Thewlis', 'funds' => '1' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Dickie Attenborough', 'funds' => '1000' })
customer2.save()
customer3 = Customer.new({ 'name' => 'Donald Pleasance', 'funds' => '500' })
customer3.save()

customer1.name = "David Lean"
customer1.update()


film1 = Film.new({ 'title' => 'Naked', 'price' => '8'})
film1.save()
film2 = Film.new({ 'title' => 'Ice Cold In Alex', 'price' => '5'})
film2.save()
film3 = Film.new({ 'title' => 'Titanic', 'price' => '1'})
film3.save()

film2.price = "8"
film2.update

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id })
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id })
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id })
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id })
ticket5.save()

film2.customers.count

customer2.films.count

# ticket1.film_id = film2.id
# ticket1.update

#customer1.delete
#film1.delete
#ticket2.delete

binding.pry
nil
