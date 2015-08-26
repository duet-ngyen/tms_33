require "rails_helper"
require "cancan/matchers"

describe "User" do
  let(:user){FactoryGirl.create :user}
  describe "create user" do
    context "when be valid user" do
      it{expect(user.errors).to be_empty}
    end
    context "when be invalid password" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_password_user}
      it{expect(user.errors[:password]).to be_present}
    end
    context "when be invalid email" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_email_user}
      it{expect(user.errors[:email]).to be_present}
    end
  end

  describe "Relationships" do
    before{
      course1 = user.courses.create FactoryGirl.attributes_for :course
      course2 = user.courses.create FactoryGirl.attributes_for :course
      subject1 = course1.subjects.create FactoryGirl.attributes_for :subject
      subject2 = course1.subjects.create FactoryGirl.attributes_for :subject
      task1 = subject1.tasks.create FactoryGirl.attributes_for :task
      task2 = subject2.tasks.create FactoryGirl.attributes_for :task
    }

    describe "Count courses, subjects, tasks of user" do
      it{expect(user.courses.count).to eq 2}
      it{expect(user.subjects.count).to eq 2}
      it{expect(user.tasks.count).to eq 2}
    end

    context "when deleting user" do
      before{user.destroy}
      it{expect(user.courses.count).to eq 0}
      it{expect(user.subjects.count).to eq 0}
      it{expect(user.tasks.count).to eq 0}
    end
  end

  describe "#classmate_with?" do
    context "isn't classmate" do
      first_user = FactoryGirl.create :user
      second_user = FactoryGirl.create :user
      it{expect(first_user.classmate_with? second_user).to eq false}
    end

    context "is classmate" do
      course = FactoryGirl.create :course
      first_user = course.users.create FactoryGirl.attributes_for :user
      second_user = course.users.create FactoryGirl.attributes_for :user
      it{expect(first_user.classmate_with? second_user).to eq true}
    end
  end
end
