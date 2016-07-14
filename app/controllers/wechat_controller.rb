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
    end
  end

  def handle_text

  end

  def handle_unsubscribe

  end

  def subscribe
    oauth = Oauth.create_or_update_user(@xml['FromUserName'])
    flash['success'] = "用户#{oauth.nickname}关注成功"
    redirect_to '/'
  end

  def scan

  end

  def unsubscribe

  end

end
