class EventPulseSensorsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_pulse_sensor_params


  def create

    respond_to do |format|
      format.json{ render json: { ok:true } }
    end

    # @event_pulse_sensor = EventPulseSensor.create(event_pulse_sensor_params)
    # @event_pulse_sensor.wristband =  Wristband.find_by_wristband_uuid event_pulse_sensor_params[:wristband_uuid]
    # @event_pulse_sensor.save!
    # respond_to do |format|
    #   format.json
    # end
  end

  private

  def load_resource
    @event_pulse_sensor = EventPulseSensor.find_by(event_pulse_sensor_params[:id])
  end

  def event_pulse_sensor_params
    params.require(:event_pulse_sensor).permit( :hits, :id )
  end

end
