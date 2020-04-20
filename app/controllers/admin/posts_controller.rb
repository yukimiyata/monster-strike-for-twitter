class Admin::PostsController < Admin::BaseController
  layout 'admin'

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
  end
end
