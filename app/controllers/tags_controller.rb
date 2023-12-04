class TagsController < ApplicationController
  def index
    @tag = Tag.includes(:post)
  end
end
