class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_comment, only: %i[show like vote]
  before_action :set_cur_user_comment, only: %i[update destroy]

  # Create a comment on a post.
  def create
    comment = current_devise_api_user.comments.new(comment_params)
    if comment.save
      render json: CommentSerializer.new(comment, include: %w[user]).serializable_hash
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  # Returns a specific comment
  def show
    if @comment
      render json: CommentSerializer.new(@comment, include: %w[user]).serializable_hash
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # Edit a comment
  def update
    if @comment&.update(comment_params)
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # Like a comment
  def like
    if params.has_key?(:like)
      if @comment
        comment_like = @comment.comments_likes.find_or_initialize_by(user_id: current_devise_api_user.id)
        case params[:like]
        when 1
          if comment_like.save
            head :no_content
          else
            render json: comment_like.errors, status: :unprocessable_entity
          end
        when 2
          if comment_like.destroy
            head :no_content
          else
            render json: comment_like.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid like attribute (expected 1 or 2)"}, status: :unprocessable_entity
        end
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Like not specified (expected 1 or 2)"}, status: :unprocessable_entity
    end
  end

  # Upvote / Downvote a comment
  def vote
    if params.has_key?(:vote)
      if @comment
        comment_vote = @comment.comments_votes.find_or_initialize_by(user_id: current_devise_api_user.id)
        case params[:vote]
        when 1..2
          if comment_vote.update(vote: params[:vote])
            head :no_content
          else
            render json: comment_vote.errors, status: :unprocessable_entity
          end
        when 3
          if comment_vote.destroy
            head :no_content
          else
            render json: comment_vote.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid vote attribute (expected 1, 2 or 3)"}, status: :unprocessable_entity
        end
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Vote not specified (expected 1, 2 or 3)"}, status: :unprocessable_entity
    end
  end

  # Delete a comment
  # WARNING: Related objects to the comment will also be deleted automatically
  # (i.e. comments likes & votes)
  def destroy
    if @comment&.destroy
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_cur_user_comment
    @comment = current_devise_api_user.comments.find(params[:id])
  end
end
