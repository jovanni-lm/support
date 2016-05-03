class AddStatusToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :status, index: true, foreign_key: true
  end
end
