class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :comment
      t.integer :user_id
      t.integer :lesson_id
      
      t.timestamps null: false
    end
  end
end
