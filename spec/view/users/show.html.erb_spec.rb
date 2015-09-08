require "rails_helper"
require "spec_helper"

RSpec.describe User, type: :view do
  feature "show user" do
    let!(:user) {FactoryGirl.create :user}
    let!(:course) do
      user.courses.create FactoryGirl.attributes_for :course
    end
    before do
      visit "/users/sign_in"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end

    scenario "Show profile" do
      click_link "View profiles"
      expect(page).to have_content user.name
      expect(page).to have_content user.email
      expect(page).to have_content user.role
      expect(page).to have_content course.title
    end

    scenario "User log out" do
      click_link "Logout"
      expect(page).to have_link "Login"
    end
  end
end
