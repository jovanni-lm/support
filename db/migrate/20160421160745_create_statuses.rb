class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :title

      t.timestamps null: false
    end

    Status.create([{ title: 'Waiting for Staff Response' },
                   { title: 'Waiting for Customer' },
                   { title: 'On Hold' },
                   { title: 'Cancelled' },
                   { title: 'Completed' }
                  ])
  end
end
