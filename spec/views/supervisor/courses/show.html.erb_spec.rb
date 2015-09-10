require "rails_helper"

RSpec.describe "supervisor/courses/show", type: :view do
  feature "display course details" do
    let!(:user) {User.create FactoryGirl.attributes_for :supervisor}
    let!(:course_ruby){Course.create FactoryGirl
      .attributes_for(:course, title: (I18n.t "rspec.course_name"), description: (I18n.t "rspec.course_description"))}
    let!(:user_1){User.create FactoryGirl.attributes_for(:user, name: (I18n.t "rspec.user_name"))}
    let!(:subject_1){Subject.create FactoryGirl.attributes_for(:subject, title: (I18n.t "rspec.subject_name"))}

    before do
      visit "/users/sign_in"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
      course_ruby.users << user_1
      course_ruby.subjects << subject_1
      visit "/supervisor/courses/#{course_ruby.id}"
    end

    it "show course infos" do
      expect(page).to have_content I18n.t "rspec.course_name"
      expect(page).to have_content I18n.t "rspec.course_description"
      expect(page).to have_content I18n.t "rspec.subject_name"
      expect(page).to have_content I18n.t "rspec.user_name"
    end

    it "link on course" do
      expect(page).to have_link I18n.t "application.link.edit_course"
      expect(page).to have_link I18n.t "application.link.add_subject"
      expect(page).to have_link I18n.t "application.string_constant.update_user_course"
      expect(page).to have_link I18n.t "rspec.subject_name"
      expect(page).to have_link I18n.t "rspec.user_name"
    end

    it "render page" do
      expect(response).to render_template("shared/_users_in_course")
      expect(response).to render_template("supervisor/courses/_add_subject_to_course")
    end
  end
end
