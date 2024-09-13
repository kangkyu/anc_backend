class AuthController < ApplicationController

  def google_oauth2
    id_token = request.headers['Authorization'].split(' ').last
    user_info = payload_id_token(id_token)

    if user_info
      user = User.from_firebase(user_info)
      render json: { token: user.generate_jwt, user: user }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def payload_id_token(id_token)
    # TODO: decode and get payload
  end
end
