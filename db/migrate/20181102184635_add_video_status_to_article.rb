class AddVideoStatusToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :video_status, :string
  end
end
