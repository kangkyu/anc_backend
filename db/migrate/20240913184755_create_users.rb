class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :firebase_user, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
