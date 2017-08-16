class MessagesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @members = @group.members.includes(:user)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path }
        format.json
      end
    else
      redirect_to group_messages_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image, :group_id).merge(group_id: params[:group_id])
  end

end
