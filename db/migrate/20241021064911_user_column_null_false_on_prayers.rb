class UserColumnNullFalseOnPrayers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :prayers, :user_id, false
  end
end
