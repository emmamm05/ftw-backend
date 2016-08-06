class RenamedBadPulseSensorsAttributes < ActiveRecord::Migration
  def change
    rename_column :event_pulse_sensors, :streaming_timestamp, :wristband_timestamp
    rename_column :event_pulse_sensors, :streaming_uuid, :wristband_uuid
  end
end
