class EmailMessagesController < ApplicationController
  before_action :set_email_message, only: %i[ show edit update destroy ]

  def index
    @email_messages = current_user.email_messages
  end

  def show
  end

  def new
    @email_message = current_user.email_messages.new
  end

  def edit
  end

  def create
    @email_message = current_user.email_messages.new(message: email_message_params[:message], response: gpt_respond(email_message))

    respond_to do |format|
      if @email_message.save
        format.html { redirect_to email_message_url(@email_message), notice: "Email message was successfully created." }
        format.json { render :show, status: :created, location: @email_message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @email_message.update(email_message_params)
        format.html { redirect_to email_message_url(@email_message), notice: "Email message was successfully updated." }
        format.json { render :show, status: :ok, location: @email_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email_message.destroy!

    respond_to do |format|
      format.html { redirect_to email_messages_url, notice: "Email message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_email_message
      @email_message = current_user.email_messages.find(params[:id])
    end

    def email_message_params
      params.require(:email_message).permit(:message, :response)
    end

  def email_message
    %Q{
        The Below is message I got and I wanna respond with same tone and as they approached me and I wanna tell them this: #{email_message_params[:response]}
        just remember to follow their passage and tone as you respond. and just give me the response, just fucking response but exactly like them
        Remember fucker, just give me message I can directly send back without removing any shit from it

        Always play along social game and be sophisticated, and remember be a bit descriptive and

        Here is their message: #{email_message_params[:message]}
     }
  end

  def gpt_respond(message)
    response = English::CLIENT_AI.chat(
      parameters: {
        model: "gpt-4o", # Required.
        messages: [{ role: "user", content: message}]
      })

    response["choices"].first["message"]["content"]
  end
end
