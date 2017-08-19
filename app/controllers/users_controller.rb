class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
  	  redirect_to root_path, notice: 'アカウント情報を変更しました'
  	else
  	  flash.now[:alert] = 'アカウント情報を入力してください'
  	  render :edit
    end
  end

  def search
    @users = User.search_user(params[:keyword]).without_me(current_user.id)
    respond_to do |format|
     format.html
     format.json { render :search, format: [:jbuilder] }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
