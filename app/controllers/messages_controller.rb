class MessagesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @members = @group.members.includes(:user)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image, :group_id).merge(group_id: params[:group_id])
  end

end
