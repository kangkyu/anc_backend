class CreatePrayers < ActiveRecord::Migration[7.1]
  def change
    create_table :prayers do |t|
      t.text :content, null: false

      t.timestamps
    end
  end
end
