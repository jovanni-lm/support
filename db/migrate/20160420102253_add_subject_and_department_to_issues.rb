class AddSubjectAndDepartmentToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :subject, :string
    add_column :issues, :department, :string
  end
end
