class WristbandsController < ApplicationController

  def index
    @wristbands = Wristband.all
  end

  private

    def load_resource

    end

end
