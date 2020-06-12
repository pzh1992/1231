class UsersController < ApplicationController

  before_action :is_admin, only: [:destroy, :index,:look_through,:edit,:update]
  
  def index
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 20).order("id desc")
    render :layout=>false
  end

  def edit
    @user = User.find(params[:id])
    render :layout=>false
   
  end

  def update
    user = User.find(params[:id]) 
    father_id = user.father_id
    end_time = Time.now + params[:month].to_i.month
     
    if father_id
      ActiveRecord::Base.transaction do
        Coupon.create!(money: params[:money], user_id: father_id)
        user = user.update!(end_time: end_time, is_active: true, offer_code: RandomCode.generate_product_uuid)
      end
    else
      user = user.update!(end_time: end_time, is_active: true, offer_code: RandomCode.generate_product_uuid)
    end
    redirect_to '/users'
  end

  def look_through
    @coupons = Coupon.includes(:user)
    render :layout=>false
  end

  def look_through_update
    Coupon.find(params[:id]).update(is_active: false,status: "off", updated_at: Time.now)
    redirect_to '/users/look_through'
  end

  def center
    @user = current_user
    @coupons = @user.coupons.where(is_active: true)
  end

  def coupon_update
    if current_user.coupons.ids.include?(params[:coupon_id].to_i)
      bool = Coupon.find(params[:coupon_id]).update(status: "look_through")
      render :json => {data: "请使用微信联系客服，完成优惠券折现。", status: "暂不可用",bool: true}
    else
      render :json => {data: '只能使用自己的优惠券哦！',bool: false}
    end
  end

  def center_update
    current_user.password = params[:password] if params[:password].present?
    flash[:notice] = '修改成功！' if current_user.save
    redirect_to '/users/center'
  end

  def new
    @user = User.new
    render :layout => false
  end

  def destroy
    @user = User.find(params[:id])
    bool  = @user.is_active.present? ? false : true
    @user.is_active = bool
    @user.save
    redirect_to users_path
  end

  def create
    if params[:register_token].present?
      father_user = User.where(offer_code: params[:register_token]).first # 查询推荐人
        if father_user.present?
          @user = User.create!(email: params[:email], password: params[:password], end_time: nil, status: "student", father_id: father_user.id)  
        else
          flash[:notice] = "推荐码填写不正确，请正确填写推荐码"
          redirect_to :back and return
        end
    else
      @user = User.create!(email: params[:email], password: params[:password], end_time: nil, status: "student", father_id: nil)
    end

    if @user.present?
      flash[:notice] = '注册成功，请登录'
    end

    redirect_to '/login'
  end

   

end
