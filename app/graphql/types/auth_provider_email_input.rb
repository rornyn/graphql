Types::AuthProviderEmailInput = GraphQL::InputObjectType.define do
  name 'AUTH_PROVIDER_Credential'

  argument :email, !types.String
  argument :password, !types.String
end
