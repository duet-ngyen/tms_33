require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course_ruby){FactoryGirl.create :course}
  let(:course_rails){FactoryGirl.create :course}
  let(:subject){FactoryGirl.create :subject}

  describe "check valid a course" do
    context "when valid" do
      let(:course){Course.create FactoryGirl.attributes_for :valid_course}
      it{expect(course).to be_valid}
    end

    context "invalid title too short" do
      let(:course){Course.create FactoryGirl.attributes_for :invalid_title_too_short}
      it{expect(course).to_not be_valid}
    end

    context "invalid title too long" do
      let(:course){Course.create FactoryGirl.attributes_for :invalid_title_too_long}
      it{expect(course).to_not be_valid}
    end

    context "invalid description too short" do
      let(:course){Course.create FactoryGirl.attributes_for :invalid_description_too_short}
      it{expect(course).to_not be_valid}
    end
  end

  describe "Relationships" do
    before {
      user1 = course_ruby.users.create FactoryGirl.attributes_for :user
      user1 = course_rails.users.create FactoryGirl.attributes_for :user
      user2 = course_ruby.users.create FactoryGirl.attributes_for :user
      subject1 = course_ruby.subjects.create FactoryGirl.attributes_for :subject
      subject2 = course_ruby.subjects.create FactoryGirl.attributes_for :subject
      subject3 = course_ruby.subjects.create FactoryGirl.attributes_for :subject
      task1 = subject1.tasks.create FactoryGirl.attributes_for :task
      task2 = subject1.tasks.create FactoryGirl.attributes_for :task
      task3 = subject1.tasks.create FactoryGirl.attributes_for :task
      task4 = subject1.tasks.create FactoryGirl.attributes_for :task
    }

    context "count number of tasks users, subjects" do
      it{expect(course_ruby.users.count).to eq 2}
      it{expect(course_ruby.subjects.count).to eq 3}
      it{expect(course_ruby.subjects.first.tasks.count).to eq 4}
    end

    context "re-count when del a user, subject" do
      before do
        course_ruby.users.first.destroy
        course_ruby.subjects.last.destroy
        course_ruby.subjects.first.tasks.first.destroy
      end
      it{expect(course_ruby.users.count).to eq 1}
      it{expect(course_ruby.subjects.count).to eq 2}
      it{expect(course_ruby.subjects.first.tasks.count).to eq 3}
      it "del tasks of a subject" do
        course_ruby.subjects.first.destroy
        expect(course_ruby.subjects.first.tasks.count).to eq 0
      end
    end

    it "count number courses of a user" do
      user1 = course_rails.users.create FactoryGirl.attributes_for :user
      course_ruby.users << user1
      expect(user1.courses.count).to eq 2
    end

    it "count users when del a course" do
      user1 = course_ruby.users.create FactoryGirl.attributes_for :user
      course_rails.users << user1
      course_ruby.destroy
      expect(user1.courses.count).to eq 1
    end
  end

  describe "check status" do
    context "not set status" do
      it{expect(course_ruby.status).to match "ready"}
    end
    context "status was set" do
      before{course_ruby.update_attributes(status: 1)}
      it{expect(course_ruby.status).to match "active"}
    end
  end

  it "scope active course" do
    course_ruby.update_attributes(status: 1)
    expect(Course.active_course).to include course_ruby
  end
end
