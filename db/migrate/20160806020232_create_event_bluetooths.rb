class CreateEventBluetooths < ActiveRecord::Migration
  def change
    create_table :event_bluetooths do |t|
      t.string :nearness
      t.datetime :wristband_timestamp
      t.string :wristband_uuid

      t.timestamps null: false
    end
  end
end
