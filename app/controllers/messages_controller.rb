class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversation = find_conversation
    if current_user == @conversation.sender || current_user== @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : current_user
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to root_path, alert: "You don't have permission"
    end
  end

  def new
    @conversation = find_conversation
  end

  def create
    @conversation = find_conversation
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")

    if @message.save
      respond_to do |format|
        format.js
      end
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