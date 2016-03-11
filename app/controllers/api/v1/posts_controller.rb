require 'rails_helper'

 class Api::V1::PostsController < Api::V1::BaseController

   before_action :authenticate_user, except: :show
   before_action :authorize_user, except: [:show, :new, :create]

   def show
      post = Post.find(params[:id])
      render json: topic.to_json, status: 200
   end

   def update
      post = Post.find(params[:id])
      post.assign_attributes(post_params)

      if post.save
        render json: post.to_json, status: 200
      else
        render json: {error: "Post update failed", status: 400}, status: 400
      end
   end


   def create
      topic = Topic.find(params[:topic_id])
      post = topic.posts.build(post_params)
      post.user = current_user

      if post.save
        render json: post.to_json, status: 200
      else
        render json: {error: "Post update failed", status: 400}, status: 400
      end
   end

   def destroy
     post = Post.find(params[:id])

     if post.destroy
       render json: topic.to_json, status: 200
     else
       render json: {error: "Post update failed", status: 400}, status: 400
     end
   end


private

  def post_params
    params.require(:post).permit(:title, :body)
  end

 end
