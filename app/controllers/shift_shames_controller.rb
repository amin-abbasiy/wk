class ShiftShamesController < ApplicationController
  before_action :set_shift_shame, only: %i[ show edit update destroy ]

  # GET /shift_shames or /shift_shames.json
  def index
    @shift_shames = ShiftShame.all
  end

  # GET /shift_shames/1 or /shift_shames/1.json
  def show
  end

  # GET /shift_shames/new
  def new
    @shift_shame = ShiftShame.new
  end

  # GET /shift_shames/1/edit
  def edit
  end

  # POST /shift_shames or /shift_shames.json
  def create
    @shift_shame = ShiftShame.new(shift_shame_params)

    respond_to do |format|
      if @shift_shame.save
        format.html { redirect_to shift_shame_url(@shift_shame), notice: "Shift shame was successfully created." }
        format.json { render :show, status: :created, location: @shift_shame }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift_shame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shift_shames/1 or /shift_shames/1.json
  def update
    respond_to do |format|
      if @shift_shame.update(shift_shame_params)
        format.html { redirect_to shift_shame_url(@shift_shame), notice: "Shift shame was successfully updated." }
        format.json { render :show, status: :ok, location: @shift_shame }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift_shame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shift_shames/1 or /shift_shames/1.json
  def destroy
    @shift_shame.destroy!

    respond_to do |format|
      format.html { redirect_to shift_shames_url, notice: "Shift shame was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift_shame
      @shift_shame = ShiftShame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_shame_params
      params.require(:shift_shame).permit(:emotion_behind_shame, :seperate_people_story, :shift_to_appriciaton, :uncover_emotion_root, :realign_with_values)
    end
end
