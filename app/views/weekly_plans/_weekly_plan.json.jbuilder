json.extract! weekly_plan, :id, :title, :week, :notes, :reflect, :actions, :ideas, :created_at, :updated_at
json.url weekly_plan_url(weekly_plan, format: :json)
