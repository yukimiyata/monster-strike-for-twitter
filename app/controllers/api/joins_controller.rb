class Api::JoinsController < ApplicationController
  def index
    post = Post.find(json_params[:id])
    recruiting_positions = post.recruiting_positions
    joins_info = []
    bool = false

    recruiting_positions.each do |r|
      joins_info << if r.joined_user.present?
                      [r.id, r.joined_user.user.name, r.joined_user.user_id, r.joined_user.user.game_name]
                    else
                      [r.id, nil, nil]
                    end
      bool = true if r.joined_user.present? && r.joined_user.user_id == current_user.id
    end
    joins = { joins_info: joins_info,
              post_status: post.started?,
              user_id: current_user.id,
              is_joined: bool,
              post_user_id: post.user_id,
              post_url: "/game_starts/" + post.id.to_s + "/starting" }
    render json: joins
  end

  private

  def json_params
    params.permit(:id)
  end
end
