class RenameEventNameToEventInEvents < ActiveRecord::Migration[7.2]
  def change
    rename_column :events, :event_name, :name
  end
end
