# Currently, create, update and destroy are not implemented.
class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_category, only: %i[show update destroy]

  # Return an array of all categories
  def index
    categories = Category.all.order(created_at: :asc)
    render json: CategorySerializer.new(categories).serializable_hash
  end

  # Create a category
  # Admin-only
  def create
    # category = Category.new(category_params)
    # if category.save
    #   render json: CategorySerializer.new(category).serializable_hash
    # else
    #   render json: category.errors, status: :unprocessable_entity
    # end
    render json: { error: "Unauthorised"}, status: :unauthorized
  end

  # Return a specific category with all its posts
  def show
    if @category
      render json: CategorySerializer.new(@category, include: [:posts]).serializable_hash
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # Edit a category
  # Admin-only
  def update
    render json: { error: "Unauthorised"}, status: :unauthorized
  end

  # Delete a category
  # Admin-only
  # WARNING: [BLOCKING] a category can only be deleted if there are no posts
  def destroy
    render json: { error: "Unauthorised"}, status: :unauthorized
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
