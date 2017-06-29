class MessagesController < ApplicationController
  before_action :authenticate_user!

  def variable
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
    @members = @group.members
  end

  def index
    variable
  end

  def create
    @message = Message.new(text: message_params[:text], image: message_params[:image], user_id: current_user.id, group_id: params[:group_id])
    if @message.save
      variable
      render :index
    else
      variable
      flash.now[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image)
  end
end
