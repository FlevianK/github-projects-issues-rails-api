class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :body
      t.string :repo
      t.integer :number

      t.timestamps
    end
  end
end
