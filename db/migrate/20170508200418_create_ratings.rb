class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :quality
      t.integer :helpfulness
      t.integer :frustration
      t.integer :time_taken

      t.timestamps null: false
    end
  end
end
