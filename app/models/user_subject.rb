class UserSubject < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :subject
  belongs_to :course_user
  has_many :user_tasks

  after_create :store_assign_activity
  after_destroy :store_delete_activity

  enum status: [:ready, :started, :finished]

  private
  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user.id, self.subject.title
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.task.title
  end
end
