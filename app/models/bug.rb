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

  def self.statuses_for_record_type(record_type)
    puts "Selected record type: #{record_type}"
    if record_type == "feature"
      statuses.select { |key, _value| [:New, :Started, :Completed].include?(key.to_sym) }
    elsif record_type == "bug"
      statuses.select { |key, _value| [:New, :Started, :Resolved].include?(key.to_sym) }
    end  
  end
end     