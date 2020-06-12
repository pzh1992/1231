class AddOfferCodeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :offer_code, :string
  	add_column :users, :session_code, :string
  	add_column :users, :is_active, :boolean, :default => true
  	add_column :articles, :is_pay, :boolean,:default => true
  end
end
