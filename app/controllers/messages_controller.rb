class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end

  def new
    @conversation = find_conversation
  end

  def create
    @conversation = find_conversation
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to @conversation, notice: "You message has been sent"
    else
      redirect_to @conversation, alert: "There is error while sending"
    end
  end

  private

  def find_conversation
    Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :conversation_id, :user_id)
  end
end