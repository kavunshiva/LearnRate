class AddHelperToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :helper_username, :string
  end
end
