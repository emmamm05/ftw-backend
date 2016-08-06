class RenamedValueToHits < ActiveRecord::Migration
  def change
    rename_column :event_pulse_sensors, :value, :hits
  end
end
