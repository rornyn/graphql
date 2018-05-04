class Resolvers::CreateMovie < GraphQL::Function
  # arguments passed as "args"
  argument :title, !types.String
  argument :summary, !types.String

  # return type from the mutation
  type Types::MovieType

  def call(obj, args, _ctx)
    Movie.create!(
      title: args[:title],
      summary: args[:summary],
    )
  end
end
