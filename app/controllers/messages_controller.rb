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
    Message.create(message_params)
    redirect_to group_messages_url
  end

  private
  def message_params
    params.require(:message).permit(:text, :image)
  end
end
