class TagsController < ApplicationController
  def index
    @tags = Tag.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC')
  end
end
