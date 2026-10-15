class FrustrationsController < ApplicationController
  before_action :set_frustration, only: %i[ show edit update destroy ]

  def index
    @frustrations = Frustration.all
  end

  def show
  end

  def new
    @frustration = Frustration.new
  end

  def edit
  end

  def create
    @frustration = Frustration.new(frustration_params)

    respond_to do |format|
      if @frustration.save
        format.html { redirect_to frustration_url(@frustration), notice: "Frustration was successfully created." }
        format.json { render :show, status: :created, location: @frustration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @frustration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @frustration.update(frustration_params)
        format.html { redirect_to frustration_url(@frustration), notice: "Frustration was successfully updated." }
        format.json { render :show, status: :ok, location: @frustration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @frustration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @frustration.destroy!

    respond_to do |format|
      format.html { redirect_to frustrations_url, notice: "Frustration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_frustration
      @frustration = Frustration.find(params[:id])
    end

    def frustration_params
      params.require(:frustration).permit(:title, :content, :trash_them, :reasons, :channeling_techniques, :created_purposes, :goals_for_purposes, :action_plan, :emotions_after_action, :result_of_emotions, :resule_of_action, :catchphrase)
    end
end
