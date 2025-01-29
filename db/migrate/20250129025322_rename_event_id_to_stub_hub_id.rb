class RenameEventIdToStubHubId < ActiveRecord::Migration[7.2]
  def change
    rename_column :events, :event_id, :stubhub_id
  end
end
