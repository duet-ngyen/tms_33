require "rails_helper"

RSpec.describe "supervisor/subjects/show", type: :view do
  feature "display subject details" do
    let!(:user) {User.create FactoryGirl.attributes_for :supervisor}
    let!(:subject){FactoryGirl.create :subject}
    let!(:task){subject.tasks.create FactoryGirl.attributes_for :task}

    before do
      visit "/users/sign_in"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
      visit "/supervisor/subjects/#{subject.id}"
    end

    it "show subject infos" do
      expect(page).to have_content subject.title
      expect(page).to have_content subject.description
      expect(page).to have_content task.title
    end

    it "link on subject" do
      expect(page).to have_link I18n.t "application.button.edit"
      expect(page).to have_link I18n.t "application.button.back"
    end
  end
end
