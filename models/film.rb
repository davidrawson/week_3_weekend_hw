require_relative ('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title , :price

  def initialize (options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2) RETURNING id"
    values= [@title, @price]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def update
    sql = "UPDATE films
    SET (title, price)
    = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers
    # a customer can buy 2 tickets for the same film
    # DISTINCT IS NOT NEEDED.
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_hashes = SqlRunner.run(sql, values)
    result = customer_hashes.map{|customer_hash| Customer.new(customer_hash)}
    return result
  end

  def self.all
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    film_hashes = films.map{|film_hash| Film.new(film_hash)}
    return film_hashes
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
