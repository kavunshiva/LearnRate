class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.string :unit_location, default: "00-00-000"
      t.string :lesson_type, default: "lab"
      t.string :url, default: "https://twitter.com/coffee_dad"

      t.timestamps null: false
    end
  end
end
