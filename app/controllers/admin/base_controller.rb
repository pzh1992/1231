class Admin::BaseController < ActionController::Base
	layout 'admin/ace'
	before_action :is_admin

	def is_admin
      if not current_user.try(:status) == "admin"
      redirect_to categories_path
      end
    end

end