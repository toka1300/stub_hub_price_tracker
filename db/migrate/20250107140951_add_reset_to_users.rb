class AddResetToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :string
    add_column :users, :datetime, :string
  end
end