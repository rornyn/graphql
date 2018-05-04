class Resolvers::SignInUser < GraphQL::Function
  argument :credential, Types::AuthProviderEmailInput

  type do
    name 'SigninPayload'
    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    return unless credential(args)
    user = User.find_by(email: email(args))
    return unless user
    return unless user.valid_password?(password(args))
    token = auth_token(user)
    ctx[:header]["uid"] = user.email
    ctx[:header]["access-token"] = token
    OpenStruct.new(user: user, token: token)
  end

  private

  def credential(args)
    args[:credential]
  end

  def email(args)
    credential(args).email
  end

  def password(args)
    credential(args).password
  end

  def auth_token(user)
    user.update_attribute('auth_token', genrate_token)
    user.auth_token
  end

  def genrate_token
    SecureRandom.urlsafe_base64(nil, false)
  end

end
