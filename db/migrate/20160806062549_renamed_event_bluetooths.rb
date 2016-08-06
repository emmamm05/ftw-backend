class RenamedEventBluetooths < ActiveRecord::Migration
  def change
    rename_column :event_bluetooths, :nearness, :distance
  end
end
