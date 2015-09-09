require "rails_helper"
require "cancan/matchers"

describe "Subject" do
  let(:subject){FactoryGirl.create :subject}
  describe "create subject" do
    context "with valid subject" do
      it{expect(subject.errors).to be_empty}
    end
    context "with invalid title" do
      let(:subject){Subject.create FactoryGirl.attributes_for :invalid_title_subject}
      it{expect(subject.errors[:title]).to be_present}
    end
    context "with invalid description" do
      let(:subject){Subject.create FactoryGirl.attributes_for :invalid_description_subject}
      it{expect(subject.errors[:description]).to be_present}
    end
  end

  describe "Relationships" do
    before do
      course1 = subject.courses.create FactoryGirl.attributes_for :course
      course2 = subject.courses.create FactoryGirl.attributes_for :course
      user1 = subject.users.create FactoryGirl.attributes_for :user
      user2 = subject.users.create FactoryGirl.attributes_for :user
      task1 = subject.tasks.create FactoryGirl.attributes_for :task
      task2 = subject.tasks.create FactoryGirl.attributes_for :task
    end

    describe "Count courses, users, tasks of subject" do
      it{expect(subject.courses.count).to eq 2}
      it{expect(subject.users.count).to eq 2}
      it{expect(subject.tasks.count).to eq 2}
    end

    context "when deleting subject" do
      before{subject.destroy}
      it{expect(subject.courses.count).to eq 0}
      it{expect(subject.users.count).to eq 0}
      it{expect(subject.tasks.count).to eq 0}
    end
  end
end
