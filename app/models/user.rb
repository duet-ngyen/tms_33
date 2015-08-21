class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :course_users
  has_many :courses, through: :course_users
  has_many :activities
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
end
