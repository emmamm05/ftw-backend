class EventBluetoothsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_bluetooth_params


  def create

    # respond_to do |format|
    #   format.json{ render json: { ok:true } }
    # end

    # @event_bluetooth = EventBluetooth.create(event_bluetooth_params)
    # @event_bluetooth.wristband =  Wristband.find_by_wristband_uuid event_bluetooth_params[:wristband_uuid]
    # @event_bluetooth.save!
    # respond_to do |format|
    #   format.json
    # end
  end

  private

  def load_resource
    @event_bluetooth = EventLocalization.find_by(event_bluetooth_params[:id])
  end

  def event_bluetooth_params
    params.require(:event_bluetooth).permit(:distance, :wristband_uuid, :wristband_timestamp,:friend_wristband_id)
  end

end
