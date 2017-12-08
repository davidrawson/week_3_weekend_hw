require_relative ('models/customer')
require_relative ('models/film')
require_relative ('models/ticket')

require ('pry-byebug')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({ 'name' => 'David Thewlis', 'funds' => '100' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Dickie Attenborough', 'funds' => '1000' })
customer2.save()

customer1.name = "David Lean"
customer1.update()

film1 = Film.new({ 'title' => 'Naked', 'price' => '8'})
film1.save()
film2 = Film.new({ 'title' => 'Ice Cold In Alex', 'price' => '5'})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()

binding.pry
nil
