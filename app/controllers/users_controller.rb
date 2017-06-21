class UsersController < ApplicationController
  before_action :authenticate_user!
  def edit
  	@user = User.find(params[:id]) 
  end

  def update
    current_user.update(user_params)
  	redirect_to controller: 'messages', action: :index
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
