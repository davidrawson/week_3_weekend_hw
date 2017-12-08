require_relative ('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name , :funds

  def initialize (options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def update
    sql = "UPDATE customers
    SET ( name, funds)
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def films
  #   sql = "SELECT films.*
  #   FROM films
  #   INNER JOIN tickets
  #   ON tickets.film_id = film.id
  #   WHERE tickets.film_id = $1"


  def self.all
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    customer_hashes = customers.map{|customer_hash| Customer.new(customer_hash)}
    return customer_hashes
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
