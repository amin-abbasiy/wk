class English < ApplicationRecord
  has_one_attached :audio

  API_KEY = ENV['ENGLISH_API_KEY']


  CLIENT_AI = OpenAI::Client.new(
    access_token: API_KEY,
    log_errors: true
  )

  belongs_to :user
end
