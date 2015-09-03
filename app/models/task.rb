class Task < ActiveRecord::Base
  after_create :update_user_tasks

  belongs_to :subject
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks

  enum status: [:opening, :closed]

  scope :finished, -> subjects {where status: 1, subject: subjects}
  scope :all_tasks, -> subjects {where subject: subjects}

  private
  def update_user_tasks
    self.subject.try(:users).each do |user|
      UserTask.create task_id: self.id, user_id: user.id
    end
  end
end
