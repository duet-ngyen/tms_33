class Course < ActiveRecord::Base
  has_many :course_users
  has_many :users, through: :course_users
  has_many :course_subjects
  has_many :subjects, through: :course_subjects  
end
