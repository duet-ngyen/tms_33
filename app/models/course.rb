class Course < ActiveRecord::Base
  before_save :set_default_status

  has_many :course_users
  has_many :users, through: :course_users
  has_many :course_subjects
  has_many :subjects, through: :course_subjects

  validates :title, presence: true
  validates :description, presence: true

  enum status: [:ready, :active, :finished]

  scope :active_course, -> {where status: 1}

  private
  def set_default_status
    self.status = :ready unless self.status.present?
  end
end
