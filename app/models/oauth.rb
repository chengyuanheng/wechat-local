class Oauth < ActiveRecord::Base
  belongs_to :user


  def self.request_user_info code
    #通过code换取网页授权access_token
    access_token_url = Constant::ACCESSTOKENURL.gsub('TEMPCODE', code)
    response = JSON.parse(RestClient.get(access_token_url)) rescue {'errcode' => -1}
    return {} if response['errcode']
    access_token, openid, scope = response['access_token'], response['openid'], response['scope']
    #拉取用户信息
    user_info_url = Constant::USERINFOURL.gsub('TEMPACCESSTOKEN', access_token).gsub('TEMPOPENID', openid)
    JSON.parse(RestClient.get(user_info_url)) rescue {'errcode' => -1}
  end


  def self.create_or_update_user openid
    access_token = self.fetch_access_token
    return if access_token.blank?
    user_info_url = Constant::UserInfoUrl.gsub('TEMPACCESSTOKEN', access_token).gsub('TEMPOPENID', openid)
    response = JSON.parse(RestClient.get user_info_url) rescue {'errcode' => -1}
    return if response['errcode']
    Rails.logger.info("wechat fetch user -> #{response}")
    oauth = find_by(openid: response["openid"])
    if oauth.present?
      oauth.update_attributes(nickname: response["nickname"], sex: response["sex"],
                              city: response["city"], province: response["province"],
                              country: response["country"], headimgurl: response["headimgurl"],
                              subscribe: response["subscribe"], subscribed_at: response["subscribe_time"])
      oauth.user.update_attributes(nickname: response["nickname"], avatar_url: response["headimgurl"])
    else
      user = User.create(nickname: response["nickname"], avatar_url: response["headimgurl"])
      oauth = create(user_id: user.id, openid: response["openid"], nickname: response["nickname"],
                     sex: response["sex"], city: response["city"], province: response["province"],
                     country: response["country"], headimgurl: response["headimgurl"],
                     subscribe: response["subscribe"], subscribed_at: response["subscribe_time"])
    end
    return oauth
  end

  private

  def self.fetch_access_token
    response = JSON.parse(RestClient.get Constant::BASEACCESSTOKENURL) rescue {'errcode' => -1}
    return if response['errcode']
    response['access_token']
  end

end
