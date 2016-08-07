class DashboardController < ApplicationController

  def index

    # build dates arrange
    minimum_date = EventPulseSensor.order(created_at: :asc).first.created_at.to_time
    maximum_date = EventPulseSensor.order(created_at: :asc).last.created_at.to_time

    # x axis
    @sleep_people_counts = []

    # sleep people graph
    @sleep_people_timestamps = []
    new_date_point = minimum_date
    while new_date_point < maximum_date do
      @sleep_people_timestamps << new_date_point.to_datetime.strftime('%F %T')
      new_date_point = new_date_point + 15.minutes

      sleep_people_count = 0
      Attendant.all.each do |attendant|
        sleep_people_count += attendant.is_sleep(new_date_point.to_datetime) ? 1 : 0
      end
      @sleep_people_counts << sleep_people_count
    end

    gon.sleep_people_counts = @sleep_people_counts
    gon.sleep_people_timestamps = @sleep_people_timestamps

    @circles = Circle.all

    # Localization
    gon.localizations_y = EventLocalization.all.to_a.map{ |event| event[:coord_y] }
    gon.localizations_x = EventLocalization.all.to_a.map{ |event| event[:coord_x] }
    gon.reference_localizations_y = EventLocalization.reference_nodes.map{ |node| node[:y] }
    gon.reference_localizations_x = EventLocalization.reference_nodes.map{ |node| node[:x] }

    respond_to do |format|
      format.html { render layout: 'dashboard_layout' }
    end

  end

  private

    def longest_sleep_streak

    end

    def total_sleep_hours
    end

end
