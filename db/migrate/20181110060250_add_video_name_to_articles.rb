class AddVideoNameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :video_name, :string
  end
end
