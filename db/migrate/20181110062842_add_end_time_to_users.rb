class AddEndTimeToUsers < ActiveRecord::Migration

  def change
  	add_column :users, :end_time, :datetime
  	add_column :users, :issue, :string
  	add_column :users, :answer, :string
  	
  end

end