class Admin::UsersController < Admin::BaseController

	def index
		@users = User.all
		@hash = User.pluck(:id, :email).to_h
	end


end