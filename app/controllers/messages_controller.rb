class MessagesController < ApplicationController
  before_action :set_index, only: [:index, :create]

  def index
  end

  def create
    @message = Message.new(message_params)
    if !@message.save
      flash.now[:alert] = 'メッセージを入力してください'
    end
    @message = Message.new
    render :index
  end

  private

  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @members = @group.members.includes(:user)
  end

end
