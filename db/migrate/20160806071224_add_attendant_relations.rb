class AddAttendantRelations < ActiveRecord::Migration
  def change

    add_reference :event_localizations, :wristband
    add_reference :event_bluetooths, :wristband
    add_reference :event_pulse_sensors, :wristband
  end
end
