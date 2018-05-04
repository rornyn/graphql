class ApplicationController < ActionController::Base
  # protect_from_forgery prepend: true, with: :exception
  helper_method :current_user

  def current_user
    return unless check_authenticate_tokens_present?
    User.find_by_email_and_auth_token(uid, access_token)
  end

  private

  def check_authenticate_tokens_present?
    access_token && uid
  end

  def access_token
    request.headers["access-token"]
  end

  def uid
    request.headers["uid"]
  end

end
