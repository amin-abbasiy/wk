json.extract! email_message, :id, :message, :response, :created_at, :updated_at
json.url email_message_url(email_message, format: :json)
