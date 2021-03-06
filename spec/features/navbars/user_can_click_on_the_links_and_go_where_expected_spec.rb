require 'rails_helper'

RSpec.feature "When a user clicks on the links in the nav bar it takes you to the expected page", type: :feature do
  context "as a guest" do
    it "guest clicks on the logo button in the navbar" do
      visit cart_path
      within(".navbar-header") do
        click_link("Minimarket logo")
      end
      expect(current_path).to eq(root_path)
    end

    it "guest clicks on the items button in the navbar" do
      visit root_path

      within(".navbar-link-items") do
        click_link("Items")
      end
      expect(current_path).to eq(items_path)
    end

    it "guest clicks on the login button in the navbar" do
      visit root_path

      within(".navbar-link-login") do
        click_link("Log In | Sign Up")
      end
      expect(current_path).to eq(login_path)
    end

    it "guest clicks on the categories button in the navbar" do
      visit root_path

      within(".navbar-link-cart") do
        click_link("Cart")
      end
      expect(current_path).to eq(cart_path)
    end
  end

  context "when a user is logged in it sees different buttons in the navbar" do
    let(:user) {User.create!(name: "John Smith", email: "jo@jo.com", password: "1234567", password_confirmation: "1234567")}

    it "user clicks on the logged in as 'user name' button in the navbar" do
      visit login_path

      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password

      click_button "Login"

      visit root_path

      within(".navbar-link-logged-in") do
        click_link("Logged in as #{user.name}")
      end
      expect(current_path).to eq(dashboard_path)
    end

    it "user clicks on the logout button in the navbar" do
      visit login_path

      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password

      click_button "Login"

      visit root_path

      within(".navbar-link-logout") do
        click_link("Logout")
      end
      expect(current_path).to eq(root_path)
    end

    it "user clicks on the logout button in the navbar" do
      visit login_path

      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password

      click_button "Login"

      visit root_path

      within(".navbar-link-orders") do
        click_link("Orders")
      end

      expect(current_path).to eq(orders_path)
    end
  end

  context "as an admin" do
    let(:user) {User.create!(name: "John Smith", email: "jo@jo.com", password: "1234567", password_confirmation: "1234567", role: 1)}

    it "click on admin button in the navbar" do

      visit login_path

      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password

      click_button "Login"

      visit root_path

      within(".navbar-link-logged-in") do
        click_link("Logged in as Admin #{user.name}")
      end

      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end
