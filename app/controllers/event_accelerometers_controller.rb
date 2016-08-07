class EventAccelerometersController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_event_accelerometer, only: [:show, :edit, :update, :destroy]

  # GET /event_accelerometers
  # GET /event_accelerometers.json
  def index
    @event_accelerometers = EventAccelerometer.all
  end

  # GET /event_accelerometers/1
  # GET /event_accelerometers/1.json
  def show
  end

  # GET /event_accelerometers/new
  def new
    @event_accelerometer = EventAccelerometer.new
  end

  # GET /event_accelerometers/1/edit
  def edit
  end

  # POST /event_accelerometers
  # POST /event_accelerometers.json
  def create

    respond_to do |format|
      format.json{ render json: { ok:true } }
    end

    # @event_accelerometer = EventAccelerometer.new(event_accelerometer_params)
    #
    # respond_to do |format|
    #   if @event_accelerometer.save
    #     format.html { redirect_to @event_accelerometer, notice: 'Event accelerometer was successfully created.' }
    #     format.json { render :show, status: :created, location: @event_accelerometer }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @event_accelerometer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /event_accelerometers/1
  # PATCH/PUT /event_accelerometers/1.json
  def update
    respond_to do |format|
      if @event_accelerometer.update(event_accelerometer_params)
        format.html { redirect_to @event_accelerometer, notice: 'Event accelerometer was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_accelerometer }
      else
        format.html { render :edit }
        format.json { render json: @event_accelerometer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_accelerometers/1
  # DELETE /event_accelerometers/1.json
  def destroy
    @event_accelerometer.destroy
    respond_to do |format|
      format.html { redirect_to event_accelerometers_url, notice: 'Event accelerometer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_accelerometer
      @event_accelerometer = EventAccelerometer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_accelerometer_params
      params.require(:event_accelerometer).permit(:state, :id)
    end
end
