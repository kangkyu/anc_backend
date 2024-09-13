class DropPrayers < ActiveRecord::Migration[7.1]
  def change
    drop_table :prayers, if_exists: true do |t|
      t.text :content, null: false

      t.timestamps
    end
  end
end
