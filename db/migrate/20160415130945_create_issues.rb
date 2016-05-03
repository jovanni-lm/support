class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.string :email
      t.text :body
      t.string :status
      t.string :task_id

      t.timestamps null: false
    end
  end
end
