class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :user_tasks
  has_many :users, through: :user_tasks

  enum status: [:opening, :closed]

  scope :finished, -> subjects {where status: 1, subject: subjects}
  scope :all_tasks, -> subjects {where subject: subjects}
end
