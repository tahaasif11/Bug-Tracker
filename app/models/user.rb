class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_type, presence: true 
  validates :name, presence: true 

  enum user_type: {manager: "manager", developer: "developer", qa: "qa"}

  has_many :created_projects, class_name: 'Project', foreign_key: 'manager_id', dependent: :destroy  
  has_many :project_users, dependent: :destroy 
  has_many :projects, through: :project_users
  has_many :bugs, class_name: 'Bug', foreign_key: 'solver_id'

  def user_project(current_user)
    if current_user.user_type=="developer" or current_user.user_type=="qa"
      projects = current_user.projects
    else  
      projects = current_user.created_projects
    end
    
    projects
  end
end
 