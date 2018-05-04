Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :movies, types[Types::MovieType] do
    resolve -> (obj, args, ctx) {
      if ctx.ast_node.selections.any? { |selection| selection.name == "actors"}
        Movie.includes(:actors)
      else
        Movie.all
      end
    }
  end

#Single Movie details
  field :movie do
   type Types::MovieType
   argument :id, !types.ID
   resolve -> (obj, args, ctx) {
    Movie.find(args[:id])
   }
  end

  field :my_data do
    type Types::UserType
    resolve -> (obj, args, ctx){
      ctx[:current_user]
    }
  end

  field :allLinks, !types[Types::LinkType] do
    resolve -> (obj, args, ctx) { Link.all }
  end

  # field :create_movie
end
