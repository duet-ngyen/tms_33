class CourseUser < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :course
  has_many :user_subjects

  after_create :store_assign_activity
  after_destroy :store_delete_activity

  private
  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user.id, self.user.name
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.task.title
  end
end
