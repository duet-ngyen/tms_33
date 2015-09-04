class CourseUser < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :course
  has_many :user_subjects, dependent: :destroy

  after_create :store_assign_activity
  after_destroy :store_delete_activity
  after_create :update_user_subject

  def all_user_tasks
    self.user_subjects.map{|user_subject| user_subject.user_tasks}.flatten
  end

  def finished_user_tasks
    self.user_subjects.map{|user_subject| user_subject.user_tasks.finished}.flatten
  end

  def progress
    100*self.finished_user_tasks.size.to_f / self.all_user_tasks.size if self.all_user_tasks
  end

  private
  def store_assign_activity
    create_activity I18n.t("application.activity_logs.assigned"),
      user.id, self.user.id, self.user.name
  end

  def store_delete_activity
    create_activity I18n.t("application.activity_logs.delete"),
      user.id, self.id, self.course.title
  end

  def update_user_subject
    self.course.subjects.each do |subject|
      UserSubject.create user_id: self.user.id,
        subject_id: subject.id, status: :ready,
        course_user_id: self.id
    end
  end
end
