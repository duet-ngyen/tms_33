require "rails_helper"
require "cancan/matchers"

describe "Task" do
  let(:subject){FactoryGirl.create :subject}
  let(:task){subject.tasks.create FactoryGirl.attributes_for :task}

  describe "Relationships" do
    before do
      user1 = subject.users.create FactoryGirl.attributes_for :user
      user2 = subject.users.create FactoryGirl.attributes_for :user
    end

    describe "Count users of task" do
      it{expect(task.users.count).to eq 2}
    end

    context "when deleting task" do
      before{task.destroy}
      it{expect(task.users.count).to eq 0}
    end
  end
end
