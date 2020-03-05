require("pry")
require_relative("models/casting")
require_relative("models/movie")
require_relative("models/star")

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({'title' => 'Parasite', 'genre' => 'thriller', 'budget' => 5000000})
movie1.save

movie2 = Movie.new({'title' => 'Dark Waters', 'genre' => 'drama', 'budget' => 2000000})
movie2.save

movie3 = Movie.new({'title' => 'Sonic', 'genre' => 'action', 'budget' => 6000000})
movie3.save

star1 = Star.new({'first_name' => 'Brad', 'last_name' => 'Pitt'})
star1.save

star2 = Star.new({'first_name' => 'Anne', 'last_name' => 'Hathaway'})
star2.save

star3 = Star.new({'first_name' => 'Jim', 'last_name' => 'Carrey'})
star3.save

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 1000000})
casting1.save

casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 4000000})
casting2.save

casting3 = Casting.new({'movie_id' => movie3.id, 'star_id' => star3.id, 'fee' => 500})
casting3.save

casting4 = Casting.new({'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 7000})
casting4.save

movie1.genre = "horror"
movie1.update

movie1.remaining_budget

binding.pry
nil
