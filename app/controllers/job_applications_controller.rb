class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: :create, if: -> { request.format.json? }
  # before_action :authorize_job_application, only: %i[show edit update destroy]

  def index    
    if params[:filter_status].blank?
      @applications = current_user.job_applications.order(created_at: :desc).sort_by(&:status)
    else
      @applications = current_user.job_applications.where(status: params[:filter_status]).order(created_at: :desc)
    end
    @all = @applications.count
    @landed = current_user.job_applications.landed.count
    @landed_ratio = current_user.job_applications.landed_ratio
    @in_progress = current_user.job_applications.in_progress.count
    @rejected = current_user.job_applications.rejected.count
    @interviewing = current_user.job_applications.interviewing.count
  end

  def statistics
    @landed = current_user.job_applications.landed.count
    @landed_ratio = current_user.job_applications.landed_ratio
    @june_landed = current_user.job_applications.june_landed
    @july_landed = current_user.job_applications.july_landed
    @august_landed = current_user.job_applications.august_landed
    @months_landed = current_user.job_applications.months_landed
    @week_applied = current_user.job_applications.week_applied
  end

  def show
  end

  def new
    @application = current_user.job_applications.new
  end

  def edit
  end

  def create
    @application = current_user.job_applications.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to job_application_url(@application), notice: "Job application was successfully created." }
        format.json { render json: { id: @application.id }, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to job_application_url(@application), notice: "Job application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @application.destroy!

    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: "Job application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_job_application
    @application = current_user.job_applications.find(params[:id])
  end

  def authorize_job_application
    authorize @application
  end

  def application_params
    params.require(:job_application).permit(:company_name, :position_title, :resume, :cover_letter, :status, :feedback, :job_description)
  end
end
