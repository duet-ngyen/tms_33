require "rails_helper"
require "spec_helper"

RSpec.describe Supervisor::UsersController, type: :controller  do
  let!(:supervisor){FactoryGirl.create :supervisor}
  let!(:user){FactoryGirl.create :user}
  let!(:another_user){FactoryGirl.create :user}
  before{sign_in supervisor}

  describe "GET index" do
    before{get :index}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :index}
  end

  describe "GET new" do
    before{get :new}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :new}
  end

  describe "POST create" do
    context "with valid attributes" do
      before{post :create, user: FactoryGirl.attributes_for(:user)}
      it{expect(response).to have_http_status 302}
      it{expect(response).to redirect_to supervisor_users_path}
    end
    context "with invalid password" do
      before{post :create, user: FactoryGirl.attributes_for(:invalid_password_user)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
    context "invalid email user" do
      before{post :create, user: FactoryGirl.attributes_for(:invalid_email_user)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
  end

  describe "DELETE destroy" do
    before do
      delete :destroy, id: user,
      user: FactoryGirl.attributes_for(:user)
    end
    it{expect(response).to redirect_to supervisor_users_path}
    it{expect(response).to have_http_status 302}
  end
end
