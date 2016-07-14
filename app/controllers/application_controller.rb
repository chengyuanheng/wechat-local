class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_variant, :wx_authorize

  def set_variant
    if request.user_agent =~ /(MicroMessenger|Windows Phone)/i
      request.variant = :wechat
    elsif request.user_agent =~ /Mobile/i
      request.variant = :mobile
    end
  end

  def wx_authorize
    if params[:code].present? #来自微信的回调
      user = Oauth.request_user_info(params[:code])
      if user['openid'].present?
        session[:openid] = user['openid']
        @current_oauth = Oauth.find_by_openid(session[:openid])
        @current_user = @current_oauth.try(:user)
      end
    elsif session[:openid]
      @current_oauth = Oauth.find_by_openid(session[:openid])
      @current_user = @current_oauth.try(:user)
    else
      # return redirect_to Constant::SNSAPIBASEURL # snsapi_base请求
      return redirect_to Constant::SNSAPIUSERINFOURL # snsapi_userinfo请求
    end
  end

end
