class AddDefaultToCadInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :cad, from: nil, to: true
  end
end
