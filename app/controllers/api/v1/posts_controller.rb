# require 'rails_helper'

 class Api::V1::PostsController < Api::V1::BaseController

   before_action :authenticate_user, except: :show
   before_action :ready_post, only: [:show, :update, :destroy]
   before_action :authorize_user, only: [:update, :destroy]

   def show
      render json: @post.to_json, status: 200
   end

   def update
      @post.assign_attributes(post_params)

      if @post.save
        render json: @post.to_json, status: 200
      else
        render json: {error: "Post update failed", status: 400}, status: 400
      end
   end


   def create
      topic = Topic.find(params[:topic_id])
      post = topic.posts.build(post_params)
      post.user = @current_user

      if post.save
        render json: post.to_json, status: 200
      else
        render json: {error: "Post update failed", status: 400}, status: 400
      end
   end

   def destroy
     if @post.destroy
       render json: {message: "Post destroyed", status: 200}, status: 200
     else
       render json: {error: "Post update failed", status: 400}, status: 400
     end
   end


private
  def ready_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    unless @current_user && (@current_user.admin? || (@current_user == @post.user))
      render json: {error: "Not Authorized", status: 403}, status: 403
    end
  end

 end
