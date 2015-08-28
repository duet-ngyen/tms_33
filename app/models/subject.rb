class Subject < ActiveRecord::Base
  has_many :user_subjects
  has_many :users, through: :user_subjects
  has_many :course_subjects
  has_many :courses, through: :course_subjects
  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :tasks,
    reject_if: lambda { |a| a[:title].blank?}, allow_destroy: true

  def name
    "##{id}. #{title}"
  end
end
