class UserSubject < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :subject
  belongs_to :course_user
  has_many :user_tasks, dependent: :destroy

  after_create :store_assign_activity, :update_user_tasks
  after_destroy :store_delete_activity

  accepts_nested_attributes_for :user_tasks,
    reject_if: lambda { |a| a[:status].blank?}, allow_destroy: true

  enum status: [:ready, :started, :finished]

  def progress
    if self.user_tasks.empty?
      0
    else
      100*self.user_tasks.finished.size.to_f / self.user_tasks.size
    end
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
