class Api::PostsController < ApplicationController
  def index
    post = current_user.posts.new
    post_params = post.process_api_attributes(body_params)
    post.assign_attributes(post_params)

    data = if post.valid?
             { quest_name: post.quest_name, valid_data: true }
           else
             { valid_data: false }
           end
    render json: data
  end

  def body_params
    params.permit(:body)
  end
end
