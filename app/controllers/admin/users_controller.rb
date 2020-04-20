class Admin::UsersController < Admin::BaseController
  layout 'admin'

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end
end
