class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :typee, presence: true 
  enum typee: {manager: "manager", developer: "developer", qa: "qa"}

  has_many :created_projects, class_name: 'Project', foreign_key: 'manager_id', dependent: :destroy  
  has_many :project_users, dependent: :destroy 
  has_many :projects, through: :project_users
  has_many :bugs, class_name: 'Bug', foreign_key: 'solver_id'
end
 