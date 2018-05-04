class Movie < ApplicationRecord
  has_and_belongs_to_many :actors

  has_many :favorite_movies
  has_many :users, :through => :favorite_movies

end
