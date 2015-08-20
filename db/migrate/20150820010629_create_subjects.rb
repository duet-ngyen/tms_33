class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :description
      t.string :status
      t.date :start_time
      t.date :end_time

      t.timestamps null: false
    end
  end
end
