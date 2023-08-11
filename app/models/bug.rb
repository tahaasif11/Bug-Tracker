class Bug < ApplicationRecord

  validates :title, presence: true, uniqueness:{case_sensitive: false}
  validates :status, presence: true
  validates :typee, presence: true
  
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :solver, class_name: 'User', foreign_key: 'solver_id'
  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

  mount_uploader :image, ImageUploader

end     