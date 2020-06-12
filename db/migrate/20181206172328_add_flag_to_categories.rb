class AddFlagToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :flag, :boolean, :default => false
  end
end
