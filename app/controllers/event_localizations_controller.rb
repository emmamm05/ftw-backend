class EventLocalizationsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_localization_params


  def create

    respond_to do |format|
      format.json{ render json: { led_status:'match' } }
    end

    # @event_localization = EventLocalization.create(event_localization_params)
    # @event_localization.wristband_uuid = Wristband.find_by_wristband_uuid(event_localization_params[:wristband_uuid])
    # @event_localization.calculate_indoor_coordinates
    # @event_localization.save!
    # respond_to do |format|
    #   format.json
    # end
  end

  private

    def load_resource
      @event_localization = EventLocalization.find_by(event_localization_params[:id])
    end

    def event_localization_params
      params.require(:event_localization).permit(:wireless_status, :id)
    end

end
