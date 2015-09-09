require "rails_helper"

RSpec.describe Supervisor::CoursesController, type: :controller do
  let!(:supervisor){User.create FactoryGirl.attributes_for :supervisor}
  let!(:course){FactoryGirl.create :course}
  let!(:another_course){FactoryGirl.create :course}
  before{sign_in supervisor}

  describe "GET #index" do
    before{get :index}
    it "populates an array of courses" do
      expect(assigns(:courses)).to include course
      expect(assigns(:courses)).to include another_course
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before{get :show, id: course}
    it "assigns the requested course to @courses" do
      expect(assigns(:course)).to eq(course)
    end

    it "renders the :show view" do
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new course" do
        expect{
          post :create, course: FactoryGirl.attributes_for(:course)
          post :create, course: FactoryGirl.attributes_for(:course)
        }.to change(Course, :count).by(2)
      end

      it "redirects to the new course" do
        post :create, course: FactoryGirl.attributes_for(:course)
        expect(response).to redirect_to supervisor_course_path(Course.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new course" do
        expect{
          post :create, course: FactoryGirl.attributes_for(:invalid_title_too_short)
        }.to_not change(Course, :count)
      end

      it "re-render the new method" do
        post :create, course: FactoryGirl.attributes_for(:invalid_title_too_short)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    before :each do
      @course = Course.create FactoryGirl.attributes_for(:course, title: "PHP Course", description:"Description for PHP course")
    end

    context "valid attributes" do
      it "located the requested @course" do
        put :update, {id: @course.to_param, course: FactoryGirl.attributes_for(:course)}
        expect(assigns(:course)).to eq(@course)
      end

      it "change @course\'s attributes" do
        put :update, id: @course,
          course: FactoryGirl.attributes_for(:course, title: "Rails Course", description:"Description for Rails Course")
        @course.reload
        expect(@course.title).to eq "Rails Course"
        expect(@course.description).to eq "Description for Rails Course"
      end

      it "redirects to the update course" do
        put :update, id: @course, course: FactoryGirl.attributes_for(:course)
        expect(response).to redirect_to supervisor_course_path(@course)
      end
    end

    context "invalid attributes" do
      it "located the requested @course" do
        put :update, {id: @course.to_param, course: FactoryGirl.attributes_for(:invalid_title_too_short)}
        expect(assigns(:course)).to eq(@course)
      end

      it "doesn't change @course\'s attributes" do
        put :update, id: @course,
          course: FactoryGirl.attributes_for(:invalid_title_too_short)
        @course.reload
        expect(@course.title).to eq "PHP Course"
        expect(@course.description).to eq "Description for PHP course"
      end

      it "re-render to the edit course" do
        put :update, id: @course, course: FactoryGirl.attributes_for(:invalid_title_too_short)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @course = Course.create FactoryGirl.attributes_for(:course)
    end

    it "deletes the course" do
      expect{
        delete :destroy, id: @course
      }.to change(Course, :count).by(-1)
    end

    it "redirects to course#index" do
      delete :destroy, id: @course
      expect(response).to redirect_to  supervisor_courses_path
    end
  end
end
