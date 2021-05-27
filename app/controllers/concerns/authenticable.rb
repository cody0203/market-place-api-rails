module Authenticable
  def current_user
    return @current_user if @current_user

    token = request.headers['Authorization']
    return nil if token.nil?

    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end
end
