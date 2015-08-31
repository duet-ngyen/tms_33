class UserTask < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  after_create :store_assign_activity
  after_destroy :store_delete_activity

  private
  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user_id, self.task.title
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.task.title
  end
end
