class CategorysController < ApplicationController

  #before_action :set_category

  def index
  end

  def show
    #@category = Category.find(params[:id])
    #@questions = @category.questions.includes(:user).order("created_at DESC")
    #binding.pry
    #render :index
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    category.save
    redirect_to root_path
  end

  #def set_category
  #  @categorys = Category.all
  #end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
