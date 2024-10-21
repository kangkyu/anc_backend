class AddCounterToPrayer < ActiveRecord::Migration[7.1]
  def change
    add_column :prayers, :counter, :integer, default: 0, null: false
  end
end
