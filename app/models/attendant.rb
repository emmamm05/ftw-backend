class Attendant < ActiveRecord::Base
  belongs_to :circle
  has_one :wristband

  private

    def is_sleep

      hearth_rate = wristband.event_pulse_sensors.map{ |event_pulse_sensor| event_pulse_sensor.  }

    end

end
