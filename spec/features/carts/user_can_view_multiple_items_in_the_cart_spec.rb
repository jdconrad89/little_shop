require 'rails_helper'

RSpec.feature "When a user adds multiple items to their cart", type: :feature do
  let(:category) {Category.create!(title: "Animals")}
  before(:each) do
    @item_1 = Item.create(title: "Miniature Pony", price: 19999.99, description: "This majestic little beauty will be the pet you always wanted and the life of any party. Who needs a cat?",
                         image: "https://c1.staticflickr.com/7/6111/6869176460_795613ac05_b.jpg", category_id: category.id)
  end

  context "multiple items can be added from the items index page" do
    scenario "multiple items are added to the cart" do
      visit items_path
      page.find("#item_#{@item_1.id}").click

      visit items_path
      page.find("#item_#{@item_1.id}").click
      visit cart_path

      expect(page).to have_content("Miniature Pony")
      expect(page).to have_content(19999.99)
      expect(page).to have_content(2)
      expect(page).to have_content(39999.98)
      expect(page).to have_content("This majestic little beauty will be the pet you always wanted and the life of any party. Who needs a cat?")
      expect(page).to have_content(19999.99)
    end
  end
end
