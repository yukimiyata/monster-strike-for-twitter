class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %w[new create test_user_1 test_user_2]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def test_user_1
    @user = login(Rails.application.credentials.test_user[:test_user_1][:email], Rails.application.credentials.test_user[:test_user_1][:password])
    redirect_to root_path, success: 'テストユーザー１でログインしました'
  end

  def test_user_2
    @user = login(Rails.application.credentials.test_user[:test_user_2][:email], Rails.application.credentials.test_user[:test_user_2][:password])
    redirect_to root_path, success: 'テストユーザー２でログインしました'
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end
end
