class InterviewCheatSheetsController < ApplicationController
  before_action :set_interview_cheat_sheet, only: %i[ show edit update destroy ]

  def index
    @interview_cheat_sheets = InterviewCheatSheet.all
  end

  def show
  end

  def new
    @interview_cheat_sheet = InterviewCheatSheet.new
  end

  def edit
  end

  def create
    @interview_cheat_sheet = InterviewCheatSheet.new(interview_cheat_sheet_params)

    respond_to do |format|
      if @interview_cheat_sheet.save
        format.html { redirect_to interview_cheat_sheet_url(@interview_cheat_sheet), notice: "Interview cheat sheet was successfully created." }
        format.json { render :show, status: :created, location: @interview_cheat_sheet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interview_cheat_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interview_cheat_sheets/1 or /interview_cheat_sheets/1.json
  def update
    respond_to do |format|
      if @interview_cheat_sheet.update(interview_cheat_sheet_params)
        format.html { redirect_to interview_cheat_sheet_url(@interview_cheat_sheet), notice: "Interview cheat sheet was successfully updated." }
        format.json { render :show, status: :ok, location: @interview_cheat_sheet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview_cheat_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interview_cheat_sheet.destroy!

    respond_to do |format|
      format.html { redirect_to interview_cheat_sheets_url, notice: "Interview cheat sheet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_interview_cheat_sheet
      @interview_cheat_sheet = InterviewCheatSheet.find(params[:id])
    end

    def interview_cheat_sheet_params
      params.require(:interview_cheat_sheet).permit(:date, :location, :company, :positon, :interviewers, :company_info, :my_pitch, :accomplishments_skills, :reason_about_position, :my_questions, :predicted_question_answers)
    end
end
