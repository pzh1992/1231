class Admin::RolesController < Admin::BaseController
  
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
    respond_to do |format|
	  format.js
	end
  end

  # def edit
  # end

  # def show
  # end

  def create
    Role.create(title: params[:role][:title])
    redirect_to admin_roles_path
  end



end