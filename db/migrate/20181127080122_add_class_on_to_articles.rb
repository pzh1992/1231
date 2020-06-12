class AddClassOnToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :exercise_name, :string
  end
end
