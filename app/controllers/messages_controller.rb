class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @messages = Message.all
    @group = Group.find(params[:group_id])
    @members = @group.members
    @groups = current_user.groups
  end

  def create
    @message = Message.new(text: message_params[:text], image: message_params[:image], user_id: current_user.id)
    if @message.save
      redirect_to group_messages_url
    else
      redirect_to group_messages_url, alert: 'メッセージを入力してください'
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :image)
  end
end
