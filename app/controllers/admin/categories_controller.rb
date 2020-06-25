class Admin::CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_name)
    
        if @category.save
          redirect_to [:admin, :categories], notice: 'Product created!'
        else
          render :new
        end
    end

    private

    def category_name
        params.require(:category).permit(
          :name
        )
      end

end
