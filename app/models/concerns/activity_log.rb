module ActivityLog
  def create_activity title, user_id, target_id, activity_type
    Activity.create!(title: title, user_id: user_id,
      target_id: target_id, activity_type: activity_type)
  end
end
