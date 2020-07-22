class Admin::DashboardController < ApplicationController
  def show
    @dashboard = {product: Product.count, category: Category.count}
  end
end
