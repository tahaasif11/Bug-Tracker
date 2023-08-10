class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|

            t.string :title
      t.text :description
      t.string :typee
      t.datetime :deadline
      t.string :status
      t.integer :creator_id
      t.integer :solver_id
      t.integer :project_id

      t.timestamps
    end
  end
end
