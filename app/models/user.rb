class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_save :assign_default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :course_users
  has_many :courses, through: :course_users
  has_many :activities
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :user_subjects
  has_many :subjects, through: :user_subjects

  mount_uploader :avatar, AvatarUploader

  enum role: [:supervisor, :trainee, :normal]

  def classmate_with? user
    !(self.courses & user.courses).empty?
  end

  private
  def assign_default_role
    self.role = I18n.t("application.user_role.normal") unless self.role.present?
  end
end
