class AddIndexToPrayings < ActiveRecord::Migration[7.1]
  def change
    add_index :prayings, [:prayer_id, :user_id], unique: true
  end
end
