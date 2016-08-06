class CreateEventLocalizations < ActiveRecord::Migration
  def change
    create_table :event_localizations do |t|
      t.float :distance_point_a
      t.float :distance_point_b
      t.float :distance_point_c
      t.datetime :wristband_timestamp
      t.string :wristband_uuid

      t.timestamps null: false
    end
  end
end
