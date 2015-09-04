class UserTask < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  after_create :store_assign_activity, :update_user_task
  after_destroy :store_delete_activity

  scope :finished, -> {where status: true}

  def finished?
    self.status
  end

  def status_to_string
    self.finished? ? I18n.t("finished") : I18n.t("opening")
  end

  private
  def update_user_task
    user_subject = UserSubject.find_by user_id: self.user_id,
      subject_id: self.task.subject_id
    self.update_attributes user_subject_id: user_subject.id
  end

  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user_id, self.task.title
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.task.title
  end
end
