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
