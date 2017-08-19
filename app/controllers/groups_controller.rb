class GroupsController < ApplicationController

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
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
    if @group.members.count != 1  #グループのメンバーが自分以外にも存在するとき
      @members = @group.members.includes(:user).without_me(current_user.id)
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.members.count != 1  #グループのメンバーが自分以外にも存在するとき
      @members = @group.members.includes(:user).without_me(current_user.id)
    end
    if @group.update(group_params)
      redirect_to group_messages_url(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

end
