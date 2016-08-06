class EventPulseSensorsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_pulse_sensor_params


  def create
    @event_pulse_sensor = EventPulseSensor.create(event_pulse_sensor_params)
    respond_to do |format|
      format.json
    end
  end

  private

  def load_resource
    @event_pulse_sensor = EventPulseSensor.find_by(event_pulse_sensor_params[:id])
  end

  def event_pulse_sensor_params
    params.require(:event_pulse_sensor).permit(:hits, :wristband_uuid, :wristband_timestamp )
  end

end
