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
      can :show, Course do |course|
        course.try(:users).include? user
      end
    end
  end
end
