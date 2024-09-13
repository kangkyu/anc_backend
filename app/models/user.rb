class User < ApplicationRecord
  validates :organization_id, presence: true

  def self.from_firebase(payload)
    where(firebase_user: payload['user_id']).first_or_initialize do |user|
      user.phone_number = payload['phone_number']
    end.tap(&:save)
  end

  def generate_jwt
    payload = { user_id: id, exp: 60.days.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
