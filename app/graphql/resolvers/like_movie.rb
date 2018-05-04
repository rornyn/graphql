class Resolvers::LikeMovie < GraphQL::Function

  argument :movie_id, !types.ID

  # type do
  #   name 'LikeMovie'
  #   argument :movie_id, !types.ID
  #   field :message, types.String
  #   # field :movie, Types::Movie
  # end

  type Types::MovieType
  # field :message,

  def call(_obj, args, _ctx)
    current_user = args[:current_user]
    if current_user
      if current_user.check_movie_already_liked?(movie_id)
        current_user.favorite_movies.create!(movie_id: args[:movie_id])
      else
        OpenStruct.new(message: "Movie is already added in your favorite list")
      end
    else
      OpenStruct.new(message: "Unauthorize access")
    end
  end
end
