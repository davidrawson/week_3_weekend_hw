require_relative ('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize (options)
    @id = options['id'].to_i
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2) RETURNING id"
    values= [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
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
