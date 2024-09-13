class AuthController < ApiController

  def firebase_auth
    id_token = request.headers['Authorization'].split(' ').last
    user_info = payload_id_token(id_token)

    if user_info
      user = User.from_firebase(user_info)
      render json: { token: user.generate_jwt }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def payload_id_token(id_token)
    # decode and get payload
    begin
      decoded_token = JWT.decode(id_token, nil, false, {
        algorithm: 'HS256',
        aud: 'anc-mobile',
        verify_aud: true
      })
      payload = decoded_token[0]
    rescue JWT::DecodeError => e
      Rails.logger.error "Invalid ID token: #{e}"
      nil
    end
  end
end
