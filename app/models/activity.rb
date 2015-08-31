class Activity < ActiveRecord::Base
  belongs_to :user

  scope :order_created_at, -> {order created_at: :desc}
end
