Types::MovieType = GraphQL::ObjectType.define do
 name "Movie"
  description "Movie Details"
  field :id, !types.ID
  field :title, types.String
  field :summary, types.String
  field :year, types.Int
  field :actors do
    type types[Types::ActorType]
    argument :size, types.Int, default_value: 10
    resolve -> (movie, args, ctx) {
      movie.actors.limit(args[:size])
    }
  end
end
