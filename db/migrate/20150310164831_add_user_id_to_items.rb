class AddUserIdToItems < ActiveRecord::Migration
  def change
  	add_column :items, :user_id, :integer, index: true
  end
end
