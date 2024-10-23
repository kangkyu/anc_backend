class Prayer < ApplicationRecord
  belongs_to :user

  has_many :prayings
  has_many :incremented_users, through: :prayings, source: :user

  validates :counter, numericality: { greater_than_or_equal_to: 0 }

  def prayed_by(user)
    prayings.exists?(user: user)
  end
end
