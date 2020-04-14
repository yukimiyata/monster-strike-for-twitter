class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from StandardError, with: :render_500
  end

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてください'
  end

  def render_404
    render file: Rails.root.join('public/404.html'),
           status: 404,
           layout: false,
           content_type: 'text/html'
  end

  def render_500(error_e)
    if error_e
      logger.error error_e.backtrace
    end

    render file: Rails.root.join('public/500.html'),
           status: 500,
           layout: false,
           content_type: 'text/html'
  end
end
