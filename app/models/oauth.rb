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
    p JSON.parse(RestClient.get(user_info_url)) rescue {}
  end

end
