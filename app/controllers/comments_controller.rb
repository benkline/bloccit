class CommentsController < ApplicationController
  helper CommentsHelper
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_action :from_post


    def create
      if from_post
       @post = Post.find(params[:post_id])
       comment = Comment.new(comment_params)
       comment.user = current_user
       @post.comments << comment

       if comment.save
         flash[:notice] = "Comment saved successfully."
         redirect_to [@post.topic, @post]
       else
         flash[:alert] = "Comment failed to save."
         redirect_to [@post.topic, @post]
       end

     else
       @topic = Topic.find(params[:topic_id])
       comment = Comment.new(comment_params)
       comment.user = current_user
       @topic.comments << comment

       if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@topic]
       else
        flash[:alert] = "Comment failed to save."
        redirect_to [@topic]
       end
     end
    end

    def destroy
      if from_post
        @post = Post.find(params[:post_id])
        comment = @post.comments.find(params[:id])

        if comment.destroy
          flash[:notice] = "Comment was deleted."
          redirect_to [@post.topic, @post]
        else
          flash[:alert] = "Comment couldn't be deleted. Try again."
          redirect_to [@post.topic, @post]
        end

      else
        @topic = Topic.find(params[:topic_id])
        comment = @topic.comments.find(params[:id])

        if comment.destroy
          flash[:notice] = "Comment was deleted."
          redirect_to [@topic]
        else
          flash[:alert] = "Comment couldn't be deleted. Try again."
          redirect_to [@topic]
        end
      end
    end

private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def authorize_user
      comment = Comment.find(params[:id])
      unless current_user == comment.user || current_user.admin?
        flash[:alert] = "You do not have permission to delete a comment."
        redirect_to [comment.posts.first.topic, comment.posts.first]
      end
    end

    def from_post
     request.original_url.include? 'posts'
    end
  end
