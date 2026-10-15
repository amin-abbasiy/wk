class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: %i[ show edit update destroy ]

  def index
    @flashcards = Flashcard.all
  end

  def show
  end

  def new
    @flashcard = Flashcard.new
  end

  def edit
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)

    respond_to do |format|
      if @flashcard.save
        format.html { redirect_to flashcard_url(@flashcard), notice: "Flashcard was successfully created." }
        format.json { render :show, status: :created, location: @flashcard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @flashcard.update(flashcard_params)
        format.html { redirect_to flashcard_url(@flashcard), notice: "Flashcard was successfully updated." }
        format.json { render :show, status: :ok, location: @flashcard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flashcards/1 or /flashcards/1.json
  def destroy
    @flashcard.destroy!

    respond_to do |format|
      format.html { redirect_to flashcards_url, notice: "Flashcard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_flashcard
      @flashcard = Flashcard.find(params[:id])
    end

    def flashcard_params
      params.require(:flashcard).permit(:content, :description, :status, :repetition)
    end
end
