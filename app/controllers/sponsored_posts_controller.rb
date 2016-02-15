class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @sponsored_post = SponsoredPost.new
    @topic = Topic.find(params[:topic_id])
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end
end
