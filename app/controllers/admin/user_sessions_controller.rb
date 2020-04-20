class Admin::UserSessionsController < Admin::BaseController
  layout 'admin_login'
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :require_admin_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, danger: 'ログアウトしました'
  end
end
