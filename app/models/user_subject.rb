class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :course_user
  has_many :user_tasks

  enum status: [:ready, :started, :finished]
end
