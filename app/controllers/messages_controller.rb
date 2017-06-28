class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @members = @group.members
    @groups = current_user.groups
  end

  def create
    @message = Message.new(text: message_params[:text], image: message_params[:image], user_id: current_user.id, group_id: params[:group_id])
    if @message.save
      redirect_to group_messages_url
    else
      redirect_to group_messages_url, alert: 'メッセージを入力してください'
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :image, :group_id)
  end
end
