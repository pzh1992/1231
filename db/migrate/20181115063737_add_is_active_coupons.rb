class AddIsActiveCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons, :is_active, :boolean, :default => true
  	add_column :coupons, :status, :string
  end
end
