require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new
    end
    it "should save when given all values" do
      @product = Product.new(name: 'shirt', quantity: 10, price: 64.99, category: @category)
      expect(@product.save).to be true
    end

    it "should error when not given a name value" do
      @product = Product.create(name: nil, quantity: 10, price: 64.99, category: @category)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should error when not given a quantity value" do
      @product = Product.create(name: 'shirt', quantity: nil, price: 64.99, category: @category)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should error when not given a price value" do
      @product = Product.create(name: 'shirt', quantity: 10, price: nil, category: @category)
      puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should error when not given a category value" do
      @product = Product.create(name: 'shirt', quantity: 10, price: 64.99, category: nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end