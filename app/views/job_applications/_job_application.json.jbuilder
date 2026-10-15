json.extract! application, :id, :company_name, :position_title, :resume, :cover_letter, :created_at, :updated_at
json.url application_url(application, format: :json)
json.resume url_for(application.resume)
json.cover_letter url_for(application.cover_letter)
