class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.text   :destination #介绍
      t.string :status
      t.integer :weight
      t.timestamps null: false
    end
  end
end
