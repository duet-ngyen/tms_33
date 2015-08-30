require "rails_helper"
RSpec.describe Course, type: :model do
  before do
    @course = Course.create(title: "course1", description: "this is course number 1")
  end

  it "Course is valid" do
    expect(@course).to be_valid
  end

  it "Course name should NOT blank" do
    @course.title = ""
    expect(@course).to_not be_valid
  end

  it "Course description should NOT be blank" do
    @course.description = ""
    expect(@course).to_not be_valid
  end
end
