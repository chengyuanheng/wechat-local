class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
    @url = Constant::WECHATREQUESTURL #微信回调地址
    @ToUserName = 'gh_0cda14b0fbe3' #开发者微信号
    @FromUserName = 'ompx_uCewykyqC6iSuE8FJzwgoHM' #发送方帐号（一个OpenID）
    @CreateTime = Time.now.to_i #消息创建时间 （整型）
    @MsgType = 'event'
    @Event = 'subscribe'
    @EventKey = ''
    @Ticket = ''
    @Latitude = ''
    @Longitude = ''
    @Precision = ''
  end

  def requests
    if params[:url].blank?
      flash[:error] = '请填写请求地址'
      return redirect_to action: 'index'
    end
    url = params[:url]
    json = {}
    json.merge!({ToUserName: params[:ToUserName]}) if params[:ToUserName].present?
    json.merge!({FromUserName: params[:FromUserName]}) if params[:FromUserName].present?
    json.merge!({CreateTime: params[:CreateTime]}) if params[:CreateTime].present?
    json.merge!({MsgType: params[:MsgType]}) if params[:MsgType].present?
    json.merge!({Event: params[:Event]}) if params[:Event].present?
    json.merge!({EventKey: params[:EventKey]}) if params[:EventKey].present?
    json.merge!({Ticket: params[:Ticket]}) if params[:Ticket].present?
    json.merge!({Latitude: params[:Latitude]}) if params[:Latitude].present?
    json.merge!({Longitude: params[:Longitude]}) if params[:Longitude].present?
    json.merge!({Precision: params[:Precision]}) if params[:Precision].present?
    if url == Constant::WECHATREQUESTURL
      return redirect_to controller: 'wechat',action: 'index', xml: json
    else
      return JSON.parse(RestClient.get(url)) rescue {'errcode' => -1}
    end
  end

end
