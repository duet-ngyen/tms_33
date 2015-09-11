require "rails_helper"

RSpec.describe Supervisor::SubjectsController, type: :controller do
  before{sign_in supervisor}
  let!(:supervisor){User.create FactoryGirl.attributes_for :supervisor}
  let!(:subject_1){FactoryGirl.create :subject}
  let!(:subject_2){FactoryGirl.create :subject}

  describe "GET #index" do
    before{get :index}
    it "populates an array of subjects" do
      expect(assigns(:subjects)).to include subject_1
      expect(assigns(:subjects)).to include subject_2
    end
    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before{get :show, id: subject_1}
    it "assigns the requested course to @subject" do
      expect(assigns(:subject)).to eq(subject_1)
    end
    it "renders the :show view" do
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new subject" do
        expect{
          post :create, subject: FactoryGirl.attributes_for(:subject)
          post :create, subject: FactoryGirl.attributes_for(:subject)
        }.to change(Subject, :count).by(2)
      end
      it "redirects to the new subject" do
        post :create, subject: FactoryGirl.attributes_for(:subject)
        expect(response).to redirect_to supervisor_subjects_path
      end
    end
    context "with invalid attributes" do
      it "does not save the new course" do
        expect{
          post :create, subject: FactoryGirl.attributes_for(:invalid_title_subject)
          post :create, subject: FactoryGirl.attributes_for(:invalid_description_subject)
        }.to_not change(Course, :count)
      end
      it "re-render the new method" do
        post :create, subject: FactoryGirl.attributes_for(:invalid_title_subject)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @subject = Subject.create FactoryGirl.attributes_for(:subject,
        title: I18n.t("rspec.subject_name"), description: I18n.t("rspec.subject_description"))
    end

    context "valid attributes" do
      it "located the requested @subject" do
        put :update, {id: @subject.to_param, subject: FactoryGirl.attributes_for(:subject)}
        expect(assigns(:subject)).to eq(@subject)
      end

      it "change @subject\'s attributes" do
        put :update, id: @subject,
          subject: FactoryGirl.attributes_for(:subject,
            title: I18n.t("rspec.subject_name_updated"), description: I18n.t("rspec.subject_description_updated"))
        @subject.reload
        expect(@subject.title).to eq I18n.t("rspec.subject_name_updated")
        expect(@subject.description).to eq I18n.t("rspec.subject_description_updated")
      end

      it "redirects to the update subject" do
        put :update, id: @subject, subject: FactoryGirl.attributes_for(:subject)
        expect(response).to redirect_to supervisor_subjects_path
      end
    end

    context "invalid attributes" do
      it "located the requested @subject" do
        put :update, {id: @subject.to_param, subject: FactoryGirl.attributes_for(:invalid_title_subject)}
        expect(assigns(:subject)).to eq(@subject)
      end

      it "doesn't change @subject\'s attributes" do
        put :update, id: @subject,
          subject: FactoryGirl.attributes_for(:invalid_title_subject)
        @subject.reload
        expect(@subject.title).to eq I18n.t("rspec.subject_name")
        expect(@subject.description).to eq I18n.t("rspec.subject_description")
      end

      it "re-render to the edit subject" do
        put :update, id: @subject,
          subject: FactoryGirl.attributes_for(:invalid_title_subject)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    it "deletes a subject" do
      expect{
        delete :destroy, id: subject_1
      }.to change(Subject, :count).by(-1)
    end
    it "redirects to subject#index" do
      delete :destroy, id: subject_1
      expect(response).to redirect_to supervisor_subjects_path
    end
  end
end
