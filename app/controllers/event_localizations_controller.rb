class EventLocalizationsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_localization_params


  def create
    @event_localization = EventLocalization.create(event_localization_params)
    respond_to do |format|
      format.json
    end
  end

  private

    def load_resource
      @event_localization = EventLocalization.find_by(event_localization_params[:id])
    end

    def event_localization_params
      params.require(:event_localization).permit(:distance_point_a, :distance_point_b, :distance_point_c,:wristband_uuid,:wristband_timestamp)
    end

end
