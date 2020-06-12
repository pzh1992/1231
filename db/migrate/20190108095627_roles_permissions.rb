class RolesPermissions < ActiveRecord::Migration
   def change
    create_table :role_permissions do |t|
        t.integer "role_id",       limit: 4, default: 0, null: false
        t.integer "permission_id", limit: 4, default: 0, null: false
        t.timestamps null: false
    end
    
    add_index "role_permissions", ["role_id"], name: "role_id", using: :btree
    add_index "role_permissions", ["permission_id"], name: "permission_id", using: :btree
  end
end
