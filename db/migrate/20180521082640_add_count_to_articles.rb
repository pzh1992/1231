class AddCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :count_count, :integer
    add_column :categories, :count_count, :integer

  end
end
