class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Product.new
  end

  def create
    @category = Product.new(product_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end
end
