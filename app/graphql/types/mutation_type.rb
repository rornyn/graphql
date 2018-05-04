Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  field :create_movie, function: Resolvers::CreateMovie.new
  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new
  field :like_movie, function: Resolvers::LikeMovie.new
  field :sign_out_user, function: Resolvers::SignOutUser.new
end
