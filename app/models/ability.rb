class Ability
  include CanCan::Ability
  def initialize user
    user ||= User.new
    if user.supervisor?
      can :manage, :all
    else
      can :update, User do |update_user|
        update_user == user
      end
      can :show, User do |current_user|
        (current_user == user) || (user.classmate_with? current_user)
      end
      can :show, Course do |course|
        course.users.include?(user) && course.active?
      end

      can :show, Subject

      can :update, UserSubject do |user_subject|
        user_subject.user == user
      end
    end
  end
end
