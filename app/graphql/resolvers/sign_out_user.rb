class Resolvers::SignOutUser < GraphQL::Function
  type do
    name 'Destroy'
    field :message, types.String
  end

  def call(_obj, args, ctx)
    current_user = ctx[:current_user]
    if current_user
      current_user.update_attribute('auth_token', nil)
      ctx[:session][:token] = nil
      response_hash(I18n.t ('signout.success'))
    else
      response_hash(I18n.t ('signout.fail'))
    end
  end

  private

  def response_hash(msg)
    OpenStruct.new(message: msg)
  end
end
