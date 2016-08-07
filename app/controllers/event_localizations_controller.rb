class EventLocalizationsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_filter :event_localization_params


  def create

    # Filters wireless status that begins with word ftw
    ssids = {}
    @_params[:wireless_status].split("\n").each do |line|
      args = line.split(',')
      if ['"FTW1"','"FTW2"','"FTW3"'].include?(args[1])

        # calculate linear distance from dbm's
        dbm = args[2]
        distance = decibels_intensity_to_meters(dbm)
        ssids[args[1]] = distance
      end
    end


    @event_localization = EventLocalization.create(
        distance_point_a: ssids['"FTW1"'],
        distance_point_b: ssids['"FTW2"'],
        distance_point_c: ssids['"FTW3"'],
        wristband_uuid: event_localization_params[:id]
    )
    @event_localization.wristband_uuid = Wristband.find_by_wristband_uuid(event_localization_params[:id])
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

    def decibels_intensity_to_meters( dbm )
      10 ** ( ( 27.55 - ( 20*Math.log10(2412) ) + dbm ) / 20 )
    end
end

end
