class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :user_subjects
end
