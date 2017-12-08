require_relative ('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    ticket_price = get_price()
    customer_funds = get_funds()
    return if customer_funds < ticket_price
    customer_funds -= ticket_price
    set_funds(@customer_id, customer_funds)
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2) RETURNING id"
    values= [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def update
    sql = "UPDATE tickets
    SET (customer_id, film_id)
    = ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_price()
    sql = "SELECT price FROM films WHERE id = $1"
    values = [@film_id]
    price_hash = SqlRunner.run(sql, values)[0]
    result =  price_hash['price'].to_i
    return result
  end

  def get_funds()
    sql = "SELECT funds FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values)[0]
    result =  customer_hash['funds'].to_i
    return result
  end

  def set_funds(customer_id, funds)
    sql = "UPDATE customers
    SET funds = $1
    WHERE id = $2"
    values = [funds, customer_id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    ticket_hashes = tickets.map{|ticket_hash| Ticket.new(ticket_hash)}
    return ticket_hashes
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
