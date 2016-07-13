class Qrcode < ActiveRecord::Base
  enum action_name: [:QR_SCENE, :QR_LIMIT_SCENE, :QR_LIMIT_STR_SCENE]

  def self.generate_qr_scene
    response = JSON.parse(RestClient.get(Constant::BASEACCESSTOKENURL)) rescue {'errcode' => -1}
    return {} if response['errcode']
    generate_qrcode_url = Constant::GENERATEQRCODEURL.gsub('TEMPTOKEN', response['access_token'])
    data = {expire_seconds: '604800', action_name: 'QR_SCENE', action_info: {scene: {scene_id: '123'}}}.to_json
    result = JSON.parse(RestClient.post(generate_qrcode_url, data)) rescue {'errcode' => -1}
    return {} if result['errcode']
    url = Constant::FETCHQRCODEURL.gsub('TEMPTICKET',result['ticket'])
    Qrcode.create!(name: "临时二维码#{Time.now.strftime('%Y%m%d%H%M%S')}", url: url, action_name: Qrcode.action_names['QR_SCENE'])
  end

  def self.generate_qr_limit_scene
    response = JSON.parse(RestClient.get(Constant::BASEACCESSTOKENURL)) rescue {'errcode' => -1}
    return {} if response['errcode']
    generate_qrcode_url = Constant::GENERATEQRCODEURL.gsub('TEMPTOKEN', response['access_token'])
    data = {action_name: 'QR_LIMIT_SCENE', action_info: {scene: {scene_id: '456'}}}.to_json
    result = JSON.parse(RestClient.post(generate_qrcode_url, data)) rescue {'errcode' => -1}
    return {} if result['errcode']
    url = Constant::FETCHQRCODEURL.gsub('TEMPTICKET',result['ticket'])
    Qrcode.create!(name: "永久二维码#{Time.now.strftime('%Y%m%d%H%M%S')}", url: url, action_name: Qrcode.action_names['QR_LIMIT_SCENE'])
  end

end
