class Prayer < ApplicationRecord
  belongs_to :user

  has_many :prayings
  has_many :incremented_users, through: :prayings, source: :user
end
