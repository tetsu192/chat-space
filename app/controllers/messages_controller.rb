class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.all
    @group = Group.find(params[:group_id])
    @members = @group.members
    @groups = current_user.groups
  end

  def create
  end

end
