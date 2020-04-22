class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if params[:denied].present?
      redirect_to root_path, notice: 'ログインをキャンセルしました'
      return
    end
    if @user = login_from(provider)
      redirect_to root_path, info: 'ログインしました'
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
      rescue
        redirect_to root_path, danger: "#{provider.titleize}でのログインに失敗しました"
      end

      redirect_to edit_user_path(@user), info: 'モンストネームを登録してください！'
    end
  end

  #example for Rails 4: add private method below and use "auth_params[:provider]" in place of
  #"params[:provider] above.

  # private
  # def auth_params
  #   params.permit(:code, :provider)
  # end

end
