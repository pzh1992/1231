class AddImageShowToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :image_show, :string
  end
end
