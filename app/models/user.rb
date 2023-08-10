class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, class_name: 'Project', foreign_key: 'manager_id', dependent: :destroy  
  has_many :project_users     
   has_many :bugs, class_name: 'Bug', foreign_key: 'solver_id', dependent: :destroy
end
