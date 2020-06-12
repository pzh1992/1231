class AddFatherIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :father_id, :integer
  end
end
