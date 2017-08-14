class MessagesController < ApplicationController
  before_action :set_variables, only: [:index, :create]

  def index
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path }
        format.json { render json: message }
      end
    else
      flash.now[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image, :group_id).merge(group_id: params[:group_id])
  end

  def set_variables
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @members = @group.members.includes(:user)
  end

end
