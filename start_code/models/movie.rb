require_relative("../db/sql_runner")
require_relative("star")

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

def save()
  sql = "INSERT INTO movies
  (
    title,
    genre,
    budget
    )
    VALUES
    (
      $1, $2, $3
      )
      RETURNING id"
   values = [@title, @genre, @budget]
   movie = SqlRunner.run(sql, values).first
   @id = movie['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM movies"
  movies = SqlRunner.run(sql)
  result = movies.map {|movie| Movie.new(movie)}
  return result
end

def update
  sql = "UPDATE movies SET (
  title,
  genre,
  budget
  ) =
  ($1, $2, $3)
  WHERE id = $4"
  values = [@title, @genre, @budget, @id]
  SqlRunner.run(sql, values)
 end

 def stars
   sql = "SELECT stars.* FROM stars
          INNER JOIN castings
          ON castings.star_id = stars.id
          WHERE movie_id = $1"
   values = [@id]
   stars = SqlRunner.run(sql, values)
   result = stars.map{|star| Star.new(star)}
   return result

 end

   # def fees
   #   sql = "SELECT SUM(castings.fee) FROM movies
   #          INNER JOIN castings
   #          ON castings.movie_id = movies.id
   #          WHERE movie_id = $1"
   #   values = [@id]
   #   fees = SqlRunner.run(sql, values).first['sum']
   #   return fees
   # end

   def remaining_budget
     sql = "SELECT SUM(castings.fee) FROM movies
            INNER JOIN castings
            ON castings.movie_id = movies.id
            WHERE movie_id = $1"
     values = [@id]
     fees = SqlRunner.run(sql, values).first['sum'].to_i
     remaining_budget = @budget.to_i - fees
     return remaining_budget
   end



end
