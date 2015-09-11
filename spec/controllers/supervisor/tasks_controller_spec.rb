require "rails_helper"

RSpec.describe Supervisor::TasksController, type: :controller do
  before{sign_in supervisor}
  let!(:supervisor){User.create FactoryGirl.attributes_for :supervisor}
  let!(:subject_1){FactoryGirl.create :subject}
  let!(:task_1) {subject_1.tasks.create FactoryGirl.attributes_for :task}

  describe "GET #show" do
    before{
      get :show, subject_id: subject_1, id: task_1
    }
    it "assigns the requested task to @tasks" do
      expect(assigns(:task)).to eq(task_1)
    end
    it "renders the :show view" do
      expect(response).to render_template :show
    end
  end

  describe "DELETE destroy" do
    it "deletes a subject" do
      expect{
        delete :destroy,subject_id: subject_1, id: task_1
      }.to change(Task, :count).by(-1)
    end
    it "redirects to subject#index" do
      delete :destroy,subject_id: subject_1, id: task_1
      expect(response).to redirect_to supervisor_subject_path subject_1
    end
  end
end
