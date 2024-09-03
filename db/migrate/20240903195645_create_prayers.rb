class CreatePrayers < ActiveRecord::Migration[7.1]
  def change
    create_table :prayers do |t|
      t.text :content, null: false
      t.string :auth0_user_id, null: false, index: true

      t.timestamps
    end
  end
end
