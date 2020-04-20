class Admin::BaseController < ApplicationController
  before_action :require_admin_login

  private

  def require_admin_login
    return unless logged_in? && current_user.general?

    redirect_to root_url, danger: '管理者権限がありません'
  end
end
