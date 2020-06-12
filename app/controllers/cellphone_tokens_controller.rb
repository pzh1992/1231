class CellphoneTokensController < ApplicationController

  def create
    if User.where(email: params[:cellphone]).present?
      render json: {status: 'error', message: "该手机号已被注册！"}
      return
    end

    unless params[:cellphone] =~ User::CELLPHONE_RE
      render json: {status: 'error', message: "手机号格式不正确！"}
      return
    end
     
    if session[:token_created_at] and
      session[:token_created_at] + 119 > Time.now.to_i
      render json: {status: 'error', message: "请#{119 - (Time.now.to_i - session[:token_created_at])}秒后再试！"}
      return
    end

    session[:token_created_at] = Time.now.to_i
    token = RandomCode.generate_cellphone_token
    VerifyToken.upsert params[:cellphone], token
    SendSMS.send params[:cellphone], "#{token} 注册验证码，请在10分钟内完成验证！"
    render json: {status: 'ok'}
  end

  def forget_password
    if not User.where(email: params[:cellphone]).present?
      render json: {status: 'error', message: "该手机号不存在！"}
      return
    end

    unless params[:cellphone] =~ User::CELLPHONE_RE
      render json: {status: 'error', message: "手机号格式不正确！"}
      return
    end
     
    if session[:token_created_at] and
      session[:token_created_at] + 119 > Time.now.to_i
      render json: {status: 'error', message: "请#{119 - (Time.now.to_i - session[:token_created_at])}秒后再试！"}
      return
    end

    session[:token_created_at] = Time.now.to_i
    token = RandomCode.generate_cellphone_token
    VerifyToken.upsert params[:cellphone], token
    SendSMS.send params[:cellphone], "#{token} 验证码登录，验证码10分钟内有效"
    render json: {status: 'ok'}
  end


  def ajax_create
      if User.where(email: params[:cellphone]).present?
        render json: {status: 'error', message: "该手机号已被注册！"}
        return
      end
    
      @ver = VerifyToken.where(token: params[:phone_token])
      if @ver.present?
        @ver = @ver.where(cellphone: params[:cellphone])
      else
        render json: {status: 'error',message: '验证码错误！'} and return
      end

      if @ver.present?
        @ver = @ver.available
      else
        render json: {status: 'error',message: '手机号错误！'} and return
      end

      if @ver.present?
        render json: {status: 'ok'} and return
      else
        render json: {status: 'error',message: '验证码过期！'} and return
      end
  end

  def ajax_select_user
    if params[:register_token].present?
      if User.where(offer_code: params[:register_token]).present?
        render json: {status: 'ok'} and return
      else
        render json: {status: 'error',message: '请填写正确推荐码'} and return
      end
    end
  end

end
