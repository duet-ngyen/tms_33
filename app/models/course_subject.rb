class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject

  after_create :update_user_subject

  private
  def update_user_subject
    self.course.users.each do |user|
      UserSubject.create user_id: user.id, subject_id: self.subject.id, status: :ready
    end
  end
end
