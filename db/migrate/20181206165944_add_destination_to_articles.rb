class AddDestinationToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :destination, :text
  end
end
