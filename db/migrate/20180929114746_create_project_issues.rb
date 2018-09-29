class CreateProjectIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :project_issues do |t|
      t.integer :project_id
      t.integer :issue_id

      t.timestamps
    end
  end
end
