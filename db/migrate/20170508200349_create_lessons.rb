class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.string :unit_location
      t.string :lesson_type

      t.timestamps null: false
    end
  end
end
