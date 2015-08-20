class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :subject_id
      t.string :status
      t.date :start_time
      t.date :end_time

      t.timestamps null: false
    end
  end
end
