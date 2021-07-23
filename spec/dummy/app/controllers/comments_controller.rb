class CommentsController < ActionController::Base
  def index
  end

  def show
    @comment = Comment.find(params[:id])
    @url = resource_url_for(@comment)
  end
end
