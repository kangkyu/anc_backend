class ApiController < ActionController::API

  private

  def current_user
    @current_user
  end

  def authenticate_token
    token = request.headers['Authorization'].split(' ').last
    decoded_token = JWT.decode(token, Rails.application.secret_key_base)
    @current_user = User.find(decoded_token[0]['user_id'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
