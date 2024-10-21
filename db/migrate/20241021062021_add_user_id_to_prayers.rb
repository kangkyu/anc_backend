class AddUserIdToPrayers < ActiveRecord::Migration[7.1]
  def change
    add_reference :prayers, :user, foreign_key: true
  end
end
