class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
    	t.string   "subject_class", limit: 255
    	t.string   "subject_action", limit: 50
    	t.boolean  "restfully",limit: 1, default: true
    	t.timestamps null: false
    end
  end
end
