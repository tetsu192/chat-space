class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_index

  def index
  end

  def create
    @message = Message.new(text: message_params[:text], image: message_params[:image], user_id: current_user.id, group_id: params[:group_id])
    unless @message.save
      flash.now[:alert] = 'メッセージを入力してください'
    end
    @message  = Message.new
    render :index
  end

  private

  def message_params
    params.require(:message).permit(:text, :image)
  end

  def set_index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups.includes(:messages)
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @members = @group.members.includes(:user)
  end

end
