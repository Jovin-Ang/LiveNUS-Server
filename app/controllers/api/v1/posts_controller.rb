class Api::V1::PostsController < ApplicationController
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, only: [:index]
  before_action :set_post, only: %i[show like vote]
  before_action :set_cur_user_post, only: %i[update destroy]

  # Returns an array of all posts.
  def index
    posts = Post.all.order(created_at: :desc)
    render json: PostSerializer.new(posts, include: %w[user status category]).serializable_hash
  end

  # Creates a post
  def create
    post = current_devise_api_user.posts.new(post_params)
    if post.save
      render json: PostSerializer.new(post, include: %w[user status]).serializable_hash
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  # Returns a specific posts with all its comments (if any)
  def show
    if @post
      render json: PostSerializer.new(@post, {
        params: {fetch_comments: true},
        include: %w[user status category posts_likes posts_votes comments comments.user comments.comments_likes comments.comments_votes]
      }).serializable_hash
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # Edit a post
  def update
    if @post&.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # Like a post
  def like
    if params.has_key?(:like)
      if @post
        post_like = @post.posts_likes.find_or_initialize_by(user_id: current_devise_api_user.id)
        case params[:like]
        when 1
          if post_like.save
            head :no_content
          else
            render json: post_like.errors, status: :unprocessable_entity
          end
        when 2
          if post_like.destroy
            head :no_content
          else
            render json: post_like.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid like attribute (expected 1 or 2)"}, status: :unprocessable_entity
        end
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Like not specified (expected 1 or 2)"}, status: :unprocessable_entity
    end
  end

  # Upvote / Downvote a post (mutually exclusive)
  def vote
    if params.has_key?(:vote)
      if @post
        post_vote = @post.posts_votes.find_or_initialize_by(user_id: current_devise_api_user.id)
        case params[:vote]
        when 1..2
          if post_vote.update(vote: params[:vote])
            head :no_content
          else
            render json: post_vote.errors, status: :unprocessable_entity
          end
        when 3
          if post_vote.destroy
            head :no_content
          else
            render json: post_vote.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid vote attribute (expected 1, 2 or 3)"}, status: :unprocessable_entity
        end
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Vote not specified (expected 1, 2 or 3)"}, status: :unprocessable_entity
    end
  end

  # Delete a post
  # WARNING: Related objects to the post will also be deleted automatically
  # (i.e. comments, post votes, comments likes, etc.)
  def destroy
    if @post&.destroy
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_cur_user_post
    @post = current_devise_api_user.posts.find(params[:id])
  end
end
