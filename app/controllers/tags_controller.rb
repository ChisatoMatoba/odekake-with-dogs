class TagsController < ApplicationController
  def index
    @tags = Tag.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC')
  end

  def show
    @tag = Tag.includes(posts: [:facility, :user, { images_attachments: :blob }]).find_by(id: params[:id])
  end
end
