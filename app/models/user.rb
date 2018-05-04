class User < ApplicationRecord
  has_secure_password

  has_many :favorite_movies
  has_many :movies, :through => :favorite_movies


  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def valid_password?(password)
    (authenticate(password)).present?
  end

  def check_movie_already_liked?(movie_id)
    movies.find (movie_id)
  end
end
