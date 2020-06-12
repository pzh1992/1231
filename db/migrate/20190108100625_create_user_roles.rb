class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
    	t.integer :user_id, limit: 4, default: 0, null: false
    	t.integer :role_id, limit: 4, default: 0, null: false
    	t.timestamps null: false
    end
  end
end
