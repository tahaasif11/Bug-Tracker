class Bug < ApplicationRecord
  validates :title, presence: true, uniqueness:{case_sensitive: false, scope: :project_id}
  validates :status, presence: true
  validates :bug_type, presence: true

  enum bug_type: {feature: "feature", bug: "bug"}, _default: 'feature'
  enum status: { New: "new", Started: "started", Completed: "completed", Resolved: "resolved" }

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :solver, class_name: 'User', foreign_key: 'solver_id', optional: true
  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

  mount_uploader :image, ImageUploader

  def allow_status
    if feature?
      [:New, :Started, :Completed]
    else
      [:New, :Started, :Resolved]
    end
  end
end     