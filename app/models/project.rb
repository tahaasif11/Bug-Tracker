class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  has_many :bugs,dependent: :destroy

end   