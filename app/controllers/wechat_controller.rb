class WechatController < ActionController::Base

  def index
    @xml = params[:xml]
    return render text: '不存在的参数' if @xml.blank?
    case @xml['MsgType']
    when 'event' then handle_event
    when 'text' then handle_text
    when 'unsubscribe' then handle_unsubscribe
    else render text: ''
    end
  end

  private

  def handle_event
    case @xml['Event']
    when 'subscribe' then subscribe
    when 'SCAN' then scan
    when 'unsubscribe' then unsubscribe
    when 'CLICK' then click #菜单点击事件
    end
  end

  def handle_text
    content = @xml['Content']
    flash['success'] = "用户发送的消息: #{content}"
    redirect_to '/'
  end

  def handle_unsubscribe
    unsubscribe
  end

  def subscribe
    oauth = Oauth.create_or_update_user(@xml['FromUserName'])
    flash['success'] = "用户#{oauth.nickname}关注成功"
    redirect_to '/'
  end

  #未关注扫码无请求, 关注会请求
  def scan
    scene_id = @xml['EventKey'].to_i
    flash['success'] = "用户扫描二维码#{scene_id}成功"
    redirect_to '/'
  end

  def unsubscribe
    oauth = Oauth.unsubscribe(@xml['FromUserName'])
    flash['success'] = "用户#{oauth.nickname}取消关注成功"
    redirect_to '/'
  end

  #菜单点击事件
  def click
    event_key = @xml['EventKey']
    flash['success'] = "用户点击菜单获取的EventKey:#{event_key}"
    redirect_to '/'
  end

end
