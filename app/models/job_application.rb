class JobApplication < ApplicationRecord
  self.table_name = 'applications'
  belongs_to :user
  has_one_attached :resume
  has_one_attached :cover_letter

  NUMBER_TO_MONTH = {
    1 => 'January',
    2 => 'February',
    3 => 'March',
    4 => 'April',
    5 => 'May',
    6 => 'June',
    7 => 'July',
    8 => 'August',
    9 => 'September',
    10 => 'October',
    11 => 'November',
    12 => 'December'
  }

  enum status: { pending: 0,
                 offered: 1,
                 rejected: 2,
                 recruiter_in_progress: 3,
                 rejected_in_recruiter_interview: 4,
                 tech_in_progress: 6,
                 rejected_in_tech_interview: 5,
                 hr_in_progress: 7,
                 rejected_in_hr: 9,
                 last_step_in_progress: 10,
                 fake_job: 8,
                 hired: 11,
                 filled: 12 }

  STATUS_TO_COLOR = {
    pending: 'warning',
    offered: 'success',
    rejected: 'danger',
    recruiter_in_progress: 'info',
    rejected_in_recruiter_interview: 'danger',
    tech_in_progress: 'info',
    rejected_in_tech_interview: 'danger',
    hr_in_progress: 'info',
    rejected_in_hr: 'danger',
    last_step_in_progress: 'info',
    fake_job: 'secondary',
    hired: 'success',
    filled: 'secondary'
  }

  scope :applied, -> { JobApplication.where(status: :pending) }
  scope :in_progress_list, -> { JobApplication.where(status: [:recruiter_in_progress, :tech_in_progress, :hr_in_progress, :last_step_in_progress]) }
  scope :rejected, -> { JobApplication.where(status: [:rejected, :rejected_in_recruiter_interview, :rejected_in_tech_interview, :rejected_in_hr] ) }

  scope :landed, -> {
    JobApplication.where.not(status: [:pending, :fake_job, :rejected])
  }

  scope :interviewing, -> {
    JobApplication.where(status: [:recruiter_in_progress,
                               :tech_in_progress,
                               :last_step_in_progress])
  }

  scope :time_landed, ->(from, to) {
    JobApplication.where(status: [:recruiter_in_progress,
                                :rejected_in_recruiter_interview,
                                :tech_in_progress,
                                :rejected_in_tech_interview,
                                :last_step_in_progress],
                    :created_at => from..to)
  }

  scope :time_applied, ->(from, to) {
    JobApplication.where(:created_at => from..to)
  }

  scope :in_progress, -> { JobApplication.not(rejected).not(JobApplication.fake_job) }


  def self.not(applications)
    JobApplication.where.not(id: applications.pluck(:id))
  end
  def self.landed_ratio
    landed.count.to_f / JobApplication.count
  end

  def self.june_landed
    month_landed(6)
  end

  def self.july_landed
    month_landed(7)
  end

  def self.august_landed
    month_landed(8)
  end

  def self.first_month
    JobApplication.find(1).created_at.month
  end

  def self.first_week
    JobApplication.find(1).created_at.beginning_of_week
  end

  def self.months_landed
    @result = {}
    (first_month..Time.now.month).each { |month| @result[month] = month_landed(month) }

    @result
  end

  def self.month_landed(month)
    JobApplication.time_landed(Time.new(2024, month, 1), Time.new(2024, month, 31)).count
  end

  def self.week_applied
    @result = {}
    week = first_week

    while Time.now > week do
      @result[week.strftime("%W")] = JobApplication.time_applied(week, week.end_of_week).count

      week = week + 1.week
    end

    @result
  end
end
