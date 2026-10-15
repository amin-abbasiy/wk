json.extract! task, :id, :weekly_plan_id, :name, :interval, :start_time, :end_time, :duration, :status, :feelings, :created_at, :updated_at
json.url task_url(task, format: :json)
