class Constant
  APPID = 'wx1e3e9fec7a02e85b' #app_id
  APPSECRET = '77d552f0ad5995309d15eb0ca7ffeb13' #app_secret
  BASEACCESSTOKENURL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{APPID}&secret=#{APPSECRET}" #获取基础access_token
  #网页授权: http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
  REDIRECTURI= 'http://192.168.10.106:8000'
  SNSAPIBASEURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{APPID}&redirect_uri=#{REDIRECTURI}&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect" #snsapi_base 获取code
  SNSAPIUSERINFOURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{APPID}&redirect_uri=#{REDIRECTURI}&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect" #snsapi_userinfo 获取获取code
  ACCESSTOKENURL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{APPID}&secret=#{APPSECRET}&code=TEMPCODE&grant_type=authorization_code" #获取网页授权access_token
  USERINFOURL = "https://api.weixin.qq.com/sns/userinfo?access_token=TEMPACCESSTOKEN&openid=TEMPOPENID&lang=zh_CN" #拉取用户信息
  #二维码创建获取 http://mp.weixin.qq.com/wiki/18/28fc21e7ed87bec960651f0ce873ef8a.html
  GENERATEQRCODEURL = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TEMPTOKEN" #生成二维码
  FETCHQRCODEURL = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=TEMPTICKET" #获取二维码

end
