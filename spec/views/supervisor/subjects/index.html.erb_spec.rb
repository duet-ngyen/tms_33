require "rails_helper"

RSpec.describe "supervisor/subjects", type: :view do
  feature "display subject details" do
    let!(:user) {User.create FactoryGirl.attributes_for :supervisor}
    let!(:subject1){FactoryGirl.create :subject}
    let!(:subject2){FactoryGirl.create :subject}

    before do
      visit "/users/sign_in"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
      visit "/supervisor/subjects"
    end

    it "list subjects" do
      expect(page).to have_content subject1.title
      expect(page).to have_content subject1.description
      expect(page).to have_content subject2.title
      expect(page).to have_content subject2.description
    end

    it "links on page" do
      expect(page).to have_link I18n.t "application.button.create_subject"
      expect(page).to have_link I18n.t "application.button.delete"
    end

    it "render" do
      expect(response).to render_template("_search_form")
    end
  end
end
