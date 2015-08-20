class User < ActiveRecord::Base
  has_many :course_users
  has_many :courses, through: :course_users
  has_many :activities
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
end
