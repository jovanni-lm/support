class AddStaffToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :staff, index: true, foreign_key: true
  end
end
