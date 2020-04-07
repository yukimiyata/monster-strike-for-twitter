class UserSessionsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(root_path, success: 'ログインしました')
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:root, success: 'ログアウトしました')
  end
end
