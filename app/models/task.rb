class Task < ApplicationRecord
  belongs_to :user
  belongs_to :weekly_plan
end
