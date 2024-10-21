class Prayer < ApplicationRecord
  has_many :users

  has_many :prayings
  has_many :incremented_users, through: :prayings, source: :user
end
