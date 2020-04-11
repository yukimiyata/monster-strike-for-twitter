class Api::PostsController < ApplicationController
  def index
    post = current_user.posts.new
    post_params = post.process_api_attributes(body_params)
    post.assign_attributes(post_params)
    data = { quest_name: post.quest_name }
    render json: data if post.valid?
  end

  def body_params
    params.permit(:body)
  end
end
