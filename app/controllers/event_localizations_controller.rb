class EventLocalizationsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_localization_params


  def create

    # Filters wireless status that begins with word ftw
    ssids = {}
    event_localization_params[:wireless_status].split("\n").each do |line|
      args = line.split(',')
      if ['FTW1','FTW2','FTW3'].contains(args[1])
        ssids[args[1]] = args[2]
      end
    end

    params = [
        distance_point_a: ssids['FTW1'],
        distance_point_b: ssids['FTW2'],
        distance_point_c: ssids['FTW3'],
        wireless_uuid: event_localization_params[:wireless_uuid]
    ]

    @event_localization = EventLocalization.create(params)
    @event_localization.wristband_uuid = Wristband.find_by_wristband_uuid(event_localization_params[:wristband_uuid])
    @event_localization.calculate_indoor_coordinates
    @event_localization.save!

    respond_to do |format|
      # FIXME: Logic that defines matches leds according to distances.
      format.json{ render json: { led_status:'match' } }
    end
  end

  private

    def load_resource
      @event_localization = EventLocalization.find_by(event_localization_params[:id])
    end

    def event_localization_params
      params.require(:event_localization).permit(:wireless_status, :id)
    end

end
