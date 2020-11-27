class UsersController < ApplicationController
  skip_before_action :require_login, only: %w[new create]
  before_action :set_user, only: %w[edit update]
  before_action :correct_users_page?, only: %w[edit update]

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_path, success: 'ユーザー登録が完了しました')
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def update
    @user.assign_attributes(user_params)
    if @user.game_name.present? && @user.save
      render :update
    else
      render :error
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :game_name, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_users_page?
    redirect_to root_path unless @user == current_user
  end
end
