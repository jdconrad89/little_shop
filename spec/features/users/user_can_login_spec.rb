require 'rails_helper'

RSpec.feature "User can log in" do
  scenario "successfully logged in" do
    user_1 = User.create!(name: "John Smith", email: "jo@jo.com", password: "1234567", password_confirmation: "1234567")
    visit root_path

    click_link "Log In | Sign Up"
    expect(current_path).to eq(login_path)

    fill_in :session_email, with: "jo@jo.com"
    fill_in :session_password, with: "1234567"

    click_button "Login"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome to the Mini Market, #{user_1.name}")
    expect(page).to have_content("jo@jo.com")
    expect(page).to have_content(user_1.orders.count)
    expect(page).to have_selector(:link_or_button, "View Order History")
  end
end
