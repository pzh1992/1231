class Admin::PermissionsController < Admin::BaseController

  def author
    role = Role.find(params[:role_id])
    fids = role.permissions.map(&:id)
    nids = []
    nids = params[:permissions].collect{|i| i.to_i} if params[:permissions]
    del_ids = fids - nids
    add_ids = nids - fids
    RolePermission.where(role_id: role.id).where(permission_id: del_ids).delete_all if del_ids.size > 0
    if add_ids.size > 0
        add_ids.each do |pid|
            RolePermission.create(role_id:role.id,permission_id:pid)
        end
    end
    flash[:success] = "授权成功"
    redirect_to :back
  end

  def index
    @permissions = Permission.all
  end

  def list
    @role = Role.find(params[:role_id])
    @role_permission_ids = @role.permissions.map(&:id)
    @permissions = Permission.all
  end

  def new
    @permission = Permission.new
  end

  def create
    Permission.create(subject_class: params[:permission][:subject_class], subject_action: params[:permission][:subject_action])
    redirect_to admin_permissions_path
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    Permission.find(params[:id]).destroy
    redirect_to :back
  end





end
