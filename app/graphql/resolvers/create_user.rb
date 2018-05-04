class Resolvers::CreateUser < GraphQL::Function
  # AuthProviderInput = GraphQL::InputObjectType.define do
  #   name 'AuthProviderSignupData'
  #   argument :email, Types::AuthProviderEmailInput
  # end


  # argument :authProvider, !AuthProviderInput
  #Accepted Argument
  argument :name, !types.String
  argument :email, !types.String
  argument :password, !types.String

  type Types::UserType

  def call(_obj, args, _ctx)
    User.create!(user_attribute(args))
  end

  private

  def user_attribute(args)
    {
    name: args[:name],
      email: args[:email],
      password: args[:password]
    }
  end
end
