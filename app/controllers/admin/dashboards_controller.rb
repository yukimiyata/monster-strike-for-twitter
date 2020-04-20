class Admin::DashboardsController < Admin::BaseController
  layout 'admin'

  def top
    @user_count = User.count
    @post_count = Post.count
  end
end
