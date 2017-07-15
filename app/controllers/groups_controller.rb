class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @group.user_ids = [current_user.id]
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_url(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    @members = @group.members
    if @members.find_by(user_id: current_user.id).blank?
      redirect_to groups_url
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_url(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { user_ids: [] } )
  end


end
