class GroupsController < ApplicationController
  before_action :search, except: [:create, :update]

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
    @members = @group.members.includes(:user).reject{|mem| mem.user_id == current_user.id } if @group.members.count >= 2
  end

  def update
    @group = Group.find(params[:id])
    @members = @group.members.includes(:user).reject{|mem| mem.user_id == current_user.id } if @group.members.count >= 2
    if @group.update(group_params)
      redirect_to group_messages_url(@group), notice: 'グループを編集しました'
    else
      redirect_to edit_group_path(@group), flash: { error: @group.errors.full_messages }
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

  def search
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10).reject{|mem| mem.id == current_user.id }
    respond_to do |format|
     format.html
     format.json { render :search, format: [:jbuilder] }
    end
  end

end
