class TtsJob < ApplicationJob
  queue_as :default

  def perform(english_id)
    @english = English.find(english_id)
    text = ActionView::Base.full_sanitizer.sanitize(@english.definition).gsub(/[^0-9a-z ]/i, '')

    response = English::CLIENT_AI.audio.speech(
      parameters: {
        model: "tts-1-hd",
        input: text,
        voice: "alloy",
        response_format: "mp3",
        speed: 1.0
      }
    )

    @english.audio.attach(
      io: StringIO.new(response, 'rb'),
      filename: audio_filename)
  end

  def audio_filename
    "audio_#{@english.id}.mp3"
  end
end
