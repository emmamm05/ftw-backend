class DashboardController < ApplicationController

  def index

    respond_to do |format|
      format.html { render layout: 'dashboard_layout' }
    end
  end

  private



end
