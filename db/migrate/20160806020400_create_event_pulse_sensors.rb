class CreateEventPulseSensors < ActiveRecord::Migration
  def change
    create_table :event_pulse_sensors do |t|
      t.integer :value
      t.string :streaming_uuid
      t.datetime :streaming_timestamp

      t.timestamps null: false
    end
  end
end
