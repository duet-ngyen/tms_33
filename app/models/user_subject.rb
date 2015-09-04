class UserSubject < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :subject
  belongs_to :course_user
  has_many :user_tasks

  after_create :store_assign_activity, :update_user_tasks
  after_destroy :store_delete_activity

  accepts_nested_attributes_for :user_tasks, allow_destroy: true

  enum status: [:ready, :started, :finished]

  def progress
    100*self.user_tasks.finished.size.to_f / self.user_tasks.size if self.user_tasks
  end

  private
  def update_user_tasks
    self.subject.tasks.each do |task|
      UserTask.create user_subject_id: self.id,
        task_id: task.id, user_id: self.user_id
    end
  end

  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user.id, self.subject.title
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.subject.title
  end
end
