require 'rails_helper'
require 'product'

#validates :name, presence: true
#validates :price, presence: true
#validates :quantity, presence: true
#validates :category, presence: true

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should be able to create a new Product' do
      @category = Category.new(id: 1, name: 'Test')
      @product = Product.new(name: "Test", price_cents: 2000, quantity: 3, category: @category)
      expect(@product).to be_valid
    end

    it 'should not be able to submit without names' do
      @category = Category.new(id: 1, name: 'Test')
      @product = Product.new(name: nil, price_cents: 2000, quantity: 3, category: @category)
      expect(@product).not_to be_valid
    end

    it 'should not be able to submit without price' do
      @category = Category.new(id: 1, name: 'Test')
      @product = Product.new(name: 'Test', price_cents: nil, quantity: 3, category: @category)
      expect(@product).not_to be_valid
    end 

    it 'should not be able to submit without quantity' do
      @category = Category.new(id: 1, name: 'Test')
      @product = Product.new(name: 'Test', price_cents: 2000, quantity: nil, category: @category)
      expect(@product).not_to be_valid
    end 

    it 'should not be able to submit without quantity' do
      @category = Category.new(id: 1, name: 'Test')
      @product = Product.new(name: 'Test', price_cents: 2000, quantity: 3, category: nil)
      expect(@product).not_to be_valid
    end 

  end
end



#cat1.products.create!({
  #name:  'Russian Spy Shoes',
  #description: Faker::Hipster.paragraph(4),
  #image: open_asset('apparel5.jpg'),
  #quantity: 8,
  #price: 1_225.00
#})
