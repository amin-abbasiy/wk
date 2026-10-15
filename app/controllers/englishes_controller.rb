class EnglishesController < ApplicationController
  before_action :set_english, only: %i[ show edit update destroy]
  after_action :save_audio, only: %i[ search ]

  # GET /englishes or /englishes.json
  def index
    @englishes = English.all
  end

  # GET /englishes/1 or /englishes/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @english }
      format.mp3 do
        send_file @english.audio.download, type: 'audio/mpeg', disposition: 'inline'
      end
    end
  end

  # GET /englishes/new
  def new
    @english = English.new
  end

  # GET /englishes/1/edit
  def edit
  end

  def search
    word = params[:word]
    # Decode the word if necessary
    word = URI.decode_www_form_component(word)

    if (@english = English.find_by(word: word)).present?
      respond_to do |format|
        format.html { redirect_to english_url(@english), notice: "English Found:)raira" }
        format.json { render json: @english }
      end
    else
      # begin
      #   response = English::CLIENT_AI.chat(
      #     parameters: {
      #       model: "gpt-4o", # Required.
      #       messages: [{ role: "user", content: message_constructor}]
      #     })

      #   @definition = response["choices"].first["message"]["content"]
      # begin
      #   content_text = "What the phrase #{word} means, give me html response as a article post starts with article tag not whole html file and use html tags not md format"
      #   response = gemeni_request(content: content_text)
      #   @definition = response["candidates"].first["content"]["parts"].first["text"]
      # rescue
      @voice = false
      content = "What the meaning of phrase #{word} in english"
      # response = openrouter_request(content: content)
      response = localai_request(content: content)
      # byebug 
      Rails::logger.info(response)
      @definition = JSON.parse(response)["message"]["content"]
      # @definition = JSON.parse(response)["choices"].first["message"]["content"]
      # end

      @english = current_user.englishes.new(word: word, definition: @definition)

      respond_to do |format|
        if @english.save!
          format.html { redirect_to english_url(@english), notice: "English was successfully created." }
          format.json { render json: @english }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @english.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def search_for_fight_club
    word = params[:word]
    # Decode the word if necessary
    word = URI.decode_www_form_component(word)

    begin
      content_text = "What the phrase in fight club book #{word} means, give me html response as a article post starts with article tag not whole html file and use html tags not md format"
      response = gemeni_request(content: content_text)
      @definition = response["candidates"].first["content"]["parts"].first["text"]
    rescue
      response = %x{
        curl https://openrouter.ai/api/v1/chat/completions \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer #{ENV.fetch('OPENROUTER_API_KEY')}" \
          -d '{
            "model": "openai/gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": "What the phrase in fight club book #{word} means, give me html response as a article post starts with article tag not whole html file and use html tags not md format"
              }
            ]
          
          }'
        }
      @definition = JSON.parse(response)["choices"].first["message"]["content"]
    # rescue
    #   @voice = false
    #   response = %x{
    #     curl http://localhost:11434/api/chat -d '{
    #         "model": "gemma2:latest",
    #         "messages": [
    #           {
    #             "role": "user",
    #             "content": "What the phrase in fight club book or movie #{word} means, give me html response as a article post starts with article tag not whole html file and use html tags not md format"
    #           }
    #         ],
    #         "stream": false
    #       }'
    # }
    #   @definition = JSON.parse(response)["message"]["content"]
    end

    @english = English.new(word: word, definition: @definition)

    respond_to do |format|
      if @english.save!
        format.html { redirect_to english_url(@english), notice: "English was successfully created." }
        format.json { render json: @english }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @english.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /englishes or /englishes.json
  def create
    @message = "What means #{english_params[:word]} means, give me concise definition. with an example."

    response = English::CLIENT_AI.chat(
      parameters: {
        model: "gpt-4o", # Required.
        messages: [{ role: "user", content: @message}]
      })

    @definition = response["choices"].first["message"]["content"]
    @english = English.new(word: english_params[:word], definition: @definition)

    respond_to do |format|
      if @english.save!
        format.html { redirect_to englishes_url, notice: "English was successfully created." }
        format.json { render :show, status: :created, location: @english }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @english.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /englishes/1 or /englishes/1.json
  def update
    respond_to do |format|
      if @english.update(english_params)
        format.html { redirect_to english_url(@english), notice: "English was successfully updated." }
        format.json { render :show, status: :ok, location: @english }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @english.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /englishes/1 or /englishes/1.json
  def destroy
    @english.destroy!

    respond_to do |format|
      format.html { redirect_to englishes_url, notice: "English was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_english
      @english = English.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def english_params
      params.fetch(:english, {})
    end

  def message_constructor
    if params[:word].split(" ").count > 1
      %Q{
        What the phrase `#{params[:word]}` means, give me concise definition and 2 use case. with bellow format as HTML format as article of post not full html file and
        remember replace real description in placeholder enclosed by []

            [phrase]

             Definition: [A detailed and descriptive definition...]
             Root: [The origin or etymology of the phrase...]
             Common Use: [A more comprehensive explanation of the phrase's usage in everyday language...]
      }
    elsif params[:word].split(" ").count == 1
      %Q{
        What `#{params[:word]}` means, give me concise definition. with bellow format as HTML format as article of post not full html file

        [Word]

          Pronunciation: /[Phonetic Pronunciation]/

          Definition: [A detailed and descriptive definition providing context and nuances of the word's meaning]

          Common Use: [A more comprehensive explanation of the word's usage in everyday language and contexts where it might be encountered]

          Normal Example: [A typical sentence using the word in a straightforward, common way]

          Absurd Example: [A humorous, exaggerated sentence that shows the word in an outlandish context]

          Sophisticated Example: [A more elegant, refined sentence that showcases the word in a highbrow or intellectual manner]

          Motivational Wish: [A motivational phrase or wish, using the word or related concepts to inspire the reader]
      }
    end
  end

  def save_audio
    unless @english.audio.attached?
      TtsJob.perform_later(@english.id)
    end
  end


  def gemeni_request(content:)
    HTTParty.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=#{ENV.fetch('GEMINI_API_KEY')}",
        headers: { "Content-Type" => "application/json" },
        body: {
          contents: [{
            parts: [{ text: content.to_s }]
          }]
        }.to_json
    )
  end

  def openrouter_request(content:)
    # headers = {
    #       "Content-Type" => "application/json",
    #       "Authorization" => "Bearer #{ENV.fetch('OPENROUTER_API_KEY')}"
    #     }
    # body = {
    #       model: "deepseek/deepseek-chat-v3.1:free",
    #       messages: [{ role: "user", content: content }]
    #     }

    # req = HTTParty.get(
    #     "https://openrouter.ai/api/v1/chat/completions",
    #     headers: headers,
    #     body: body.to_json
    #mistralai/mistral-nemo:free
    # mistralai/mistral-nemo:free
    # )qwen/qwen3-4b:free
# qwen/qwen3-4b:free

    req = %x{
        curl https://openrouter.ai/api/v1/chat/completions \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer #{ENV.fetch('OPENROUTER_API_KEY')}" \
          -d '{
          "model": "qwen/qwen-2.5-vl-7b-instruct:free",
          "messages": [
              {
                "role": "user",
                "content": "#{content}"
              }
            ]
          
        }'
    }
  end

  def localai_request(content:)
    %x{
          curl http://localhost:11434/api/chat \
            -d '{
              "model": "artifish/llama3.2-uncensored:latest",
              "messages": [
                { "role": "user", "content": "#{content}" }
              ],
              "stream": false
            }'
       }
  end

  def grok_request(content:)
    req = %x{
      curl https://api.x.ai/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer #{ENV.fetch('XAI_API_KEY')}" \
      -d '{
        "messages": [
          {
            "role": "system",
            "content": "You are a sentence interpreter in english and german"
          },
          {
            "role": "user",
            "content": "#{content}"
          }
        ],
        "model": "grok-4-latest",
        "stream": false,
        "temperature": 0
      }'
    }
  end
end
