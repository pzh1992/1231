class SessionsController < ApplicationController
  
  def new
    render :layout => false
  end

  def create
    #如果是验证码登录
    if params[:phone_token].present?
      if not User.where(email: params[:email]).present?
        flash[:notice] = "手机号未注册！"
        redirect_to :back and return
      end

      @ver = VerifyToken.where(token: params[:phone_token])
      if @ver.present?
        @ver = @ver.where(cellphone: params[:email])
      else
        flash[:notice] = "验证码错误！"
        redirect_to :back and return 
      end

      if @ver.present?
        @ver = @ver.available
      else
        flash[:notice] = "手机号错误！"
        redirect_to :back and return
      end

      if @ver.present?
        user = User.where(email: params[:email]).last.update(password: '123456')
        if user = login(params[:email], '123456')
          if current_user.end_time.to_i < Time.now.to_i
              if not current_user.status == "admin"
                 current_user.update(is_active: false)
               end
            end
              flash[:notice] = "密码初始化为123456请尽快进入个人中心完成修改密码！"
              redirect_to categories_path
            else
              flash[:notice] = "登录失败！"
              redirect_to :back
          end
        else
          flash[:notice] = "验证码过期！"
          redirect_to :back and return
        end
    end

    #如果不是验证码登录
    if not params[:phone_token].present?
      if user = login(params[:email], params[:password])
        if current_user.end_time.to_i < Time.now.to_i
          if not current_user.status == "admin"
             current_user.update(is_active: false)
           end
        end
        flash[:notice] = "登录成功！"
        redirect_to categories_path
      else
        flash[:notice] = "登录失败！"
        redirect_to '/login'
      end
    end


  end

  def password
    render :layout => false
  end

  def query_password
    user = User.where(email: params[:username], status: "student").first
    information = user.present? ? user.issue : false
    render json: {data: information}
  end

  def password_answer
    user = User.where(email: params[:username], status: "student").first
    bool = user.answer == params[:answer] && user.telephone == params[:phone] ? user.id : false
    render :json => {data: bool}
  end

  def password_create
    User.find(params[:user_id]).update(password:params[:password])
    flash[:notice] = "修改成功！"
    redirect_to '/login'
  end

  def delete_login_out
    logout
    redirect_to categories_path
  end

end
