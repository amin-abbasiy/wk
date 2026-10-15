class Reflection < ApplicationRecord
  enum nature: { daily: 0, weekly: 1, monthly: 2, yearly: 3, work_experience: 4, practice: 5, emotion: 6 }, _prefix: true

  NATURE_MAP =  { daily: "label label-success",
                  weekly: "label label-primary",
                  monthly: "label label-info",
                  yearly: "label label-warning",
                  work_experience: "label bg-olive",
                  practice: "label bg-orange",
                  emotion: "label bg-pink"}
  
  belongs_to :user
end
