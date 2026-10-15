class WeeklyPlan < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  enum nature: { daily: 0, weekly: 1 }
end
