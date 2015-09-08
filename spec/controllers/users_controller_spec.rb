require "rails_helper"
require "spec_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before{sign_in user}

  describe "GET show" do
    before{get :show, id: user}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :show}
  end

  describe "GET edit" do
    before{get :edit, id: user}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :edit}
  end

  describe "PUT update" do
    context "with valid attributes" do
      before do
        put :update, id: user, user: FactoryGirl.attributes_for(:user)
      end
      it{expect(response).to redirect_to action: :show}
      it{expect(response).to have_http_status 302}
    end
    context "with invalid email" do
      before do
        post :update, id: user,
        user: FactoryGirl.attributes_for(:invalid_email_user)
      end
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :edit}
    end
  end
end
