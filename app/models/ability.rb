# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user ||= User.new
    if user.manager?
      can :read, :all
      can :edit, Project, manager_id: user.id
      can :edit, Project, manager_id: user.id
      can :update, Project, manager_id: user.id
      can :destroy, Project, manager_id: user.id
    elsif user.developer?
      can :read, Bug
      can :edit, Bug, solver_id: user.id
      can :update, Bug, solver_id: user.id
      can :read, Project
    elsif user.qa?
      can :read, Bug
      can :create, Bug
      can :edit, Bug, creator_id: user.id
      can :update, Bug, creator_id: user.id
      can :destroy, Bug, creator_id: user.id
      can :read, Project
    end  
  end
end
