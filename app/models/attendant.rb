class Attendant < ActiveRecord::Base
  belongs_to :circle
  has_one :wristband


  # Finds out if a person is sleep
  #FIXME: Test is_sleep(timestamp)
  def is_sleep(timestamp)

    hearth_rate_hits = self.wristband.event_pulse_sensors.map{ |event_pulse_sensor| event_pulse_sensor.hits }

    average_total_hearth_rate_hits = hearth_rate_hits.inject{ |sum, el| sum + el }.to_f / hearth_rate_hits.count

    # calculate nearest value between timestamps
    timestamps_offsets = []
    self.wristband.event_pulse_sensors.each do |event|
      timestamps_offsets << (event.created_at.strftime('%s').to_i - timestamp.strftime('%s').to_i).abs
    end

    # finding nearest hits.
    sampling = [timestamps_offsets.count - 1,10].min
    nearest_hits_timestamps_offsets = timestamps_offsets.sort[0..sampling]

    lower_indexes_timestamps = []
    nearest_hits_timestamps_offsets.each do |hit|
      lower_indexes_timestamps << nearest_hits_timestamps_offsets.find_index(hit)
    end

    local_hearth_rate_hits = []
    lower_indexes_timestamps.each do |index|
      local_hearth_rate_hits << hearth_rate_hits[index]
    end

    average_local_hearth_rate_hits = local_hearth_rate_hits.inject{ |sum, el| sum + el }.to_f / local_hearth_rate_hits.count

    return average_local_hearth_rate_hits < (average_total_hearth_rate_hits * 0.62)
  end

end
