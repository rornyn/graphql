Types::UserType = GraphQL::ObjectType.define do
 name "User"
  description "detail of user"
  field :id, types.ID
  field :email, !types.String
  field :name, types.String
  field :favorite_movies do
    type types[Types::MovieType]
    argument :size, types.Int, default_value: 10
    resolve -> (user, args, ctx) {
      user.movies.limit(args[:size])
    }
  end
end
