class AttendantsController < ApplicationController
  before_action :set_attendant, only: [:show, :edit, :update, :destroy]

  # GET /attendants
  # GET /attendants.json
  def index
    @attendants = Attendant.all
  end

  # GET /attendants/1
  # GET /attendants/1.json
  def show
  end

  # GET /attendants/new
  def new
    @attendant = Attendant.new
  end

  # GET /attendants/1/edit
  def edit
  end

  # POST /attendants
  # POST /attendants.json
  def create
    @attendant = Attendant.new(attendant_params)

    respond_to do |format|
      if @attendant.save
        format.html { redirect_to @attendant, notice: 'Attendant was successfully created.' }
        format.json { render :show, status: :created, location: @attendant }
      else
        format.html { render :new }
        format.json { render json: @attendant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendants/1
  # PATCH/PUT /attendants/1.json
  def update
    respond_to do |format|
      if @attendant.update(attendant_params)
        format.html { redirect_to @attendant, notice: 'Attendant was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendant }
      else
        format.html { render :edit }
        format.json { render json: @attendant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendants/1
  # DELETE /attendants/1.json
  def destroy
    @attendant.destroy
    respond_to do |format|
      format.html { redirect_to attendants_url, notice: 'Attendant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendant
      @attendant = Attendant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendant_params
      params.require(:attendant).permit(:name, :lastname, :age, :gender, :circle_id, :wristband_id, :area)
    end
end
