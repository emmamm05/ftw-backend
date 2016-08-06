class Wristband < ActiveRecord::Base
  belongs_to :attendant
  has_many :event_pulse_sensors
  has_many :event_bluetooths
  has_many :event_localizations

end
