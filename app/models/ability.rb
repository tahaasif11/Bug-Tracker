# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :read, Bug do |bug|
        bug.project.manager_id == user.id
      end
      can :read, Project, manager_id: user.id
      can :edit, Project, manager_id: user.id
      can :create, Project
      can :update, Project, manager_id: user.id
      can :destroy, Project, manager_id: user.id
    elsif user.developer?
      can :read, Bug do |bug|
        user.projects.pluck(:id).include?(bug.project_id)
      end
      can :edit, Bug, solver_id: user.id
      can :update, Bug, solver_id: user.id
      can :read, Project do |project|
        user.projects.pluck(:id).include?(project.id)
      end
    elsif user.qa?
      can :read, Bug do |bug|
        user.projects.pluck(:id).include?(bug.project_id)
      end
      can :create, Bug
      can :edit, Bug, creator_id: user.id
      can :update, Bug, creator_id: user.id
      can :destroy, Bug, creator_id: user.id
      can :read, Project do |project|
        user.projects.pluck(:id).include?(project.id)
      end
    end  
  end
end