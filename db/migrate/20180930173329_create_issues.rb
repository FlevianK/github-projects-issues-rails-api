class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :body
      t.string :repo
      t.integer :number

      t.timestamps
    end
  end
end
