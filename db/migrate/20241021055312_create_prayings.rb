class CreatePrayings < ActiveRecord::Migration[7.1]
  def change
    create_table :prayings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prayer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
