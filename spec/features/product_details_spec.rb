require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do

    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
       )
      end
    end

  scenario "They click on the product to see its details" do
    # ACT
    visit root_path
    
    #Click Attempts
    
    #within first(".btn btn-default pull-right") do
    #  click_link "Details"
    #end
    #click_on(class: 'btn btn-default pull-right')
    #click_on 'Details'
    #within first(".btn btn-default pull-right") do
    # click_link "Details »"
    #end
    #first('.actions').click_link('Details')
    #first('a.btn btn-default pull-right').click_on('Details')
    #first(:css,".action").hover.find(".btn btn-default pull-right").click_on("Details")


    #<%= link_to product, class: 'btn btn-default pull-right' do %>
      #Details &raquo;
    #<% end %>

    first(".btn.btn-default.pull-right").click
    sleep 1

    # DEBUG
    save_screenshot
    puts page.html

    # VERIFY
    expect(page).to have_css 'article.product-detail'

  end
end
