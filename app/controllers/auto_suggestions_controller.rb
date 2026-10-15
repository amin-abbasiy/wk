class AutoSuggestionsController < ApplicationController
  before_action :set_auto_suggestion, only: %i[ show edit update destroy ]

  # GET /auto_suggestions or /auto_suggestions.json
  def index
    @auto_suggestions = AutoSuggestion.all
  end

  # GET /auto_suggestions/1 or /auto_suggestions/1.json
  def show
  end

  # GET /auto_suggestions/new
  def new
    @auto_suggestion = AutoSuggestion.new
  end

  # GET /auto_suggestions/1/edit
  def edit
  end

  # POST /auto_suggestions or /auto_suggestions.json
  def create
    @auto_suggestion = AutoSuggestion.new(auto_suggestion_params)

    respond_to do |format|
      if @auto_suggestion.save
        format.html { redirect_to auto_suggestion_url(@auto_suggestion), notice: "Auto suggestion was successfully created." }
        format.json { render :show, status: :created, location: @auto_suggestion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auto_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auto_suggestions/1 or /auto_suggestions/1.json
  def update
    respond_to do |format|
      if @auto_suggestion.update(auto_suggestion_params)
        format.html { redirect_to auto_suggestion_url(@auto_suggestion), notice: "Auto suggestion was successfully updated." }
        format.json { render :show, status: :ok, location: @auto_suggestion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auto_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auto_suggestions/1 or /auto_suggestions/1.json
  def destroy
    @auto_suggestion.destroy!

    respond_to do |format|
      format.html { redirect_to auto_suggestions_url, notice: "Auto suggestion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auto_suggestion
      @auto_suggestion = AutoSuggestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def auto_suggestion_params
      params.require(:auto_suggestion).permit(:idea, :faith, :plan, :action, :persistence)
    end
end
