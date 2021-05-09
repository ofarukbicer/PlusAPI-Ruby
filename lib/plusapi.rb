require 'uri'
require 'net/http'
require 'cgi'
require 'json'

class PlusAPI
  attr_accessor :token,:bilgi

  def initialize(token)
    @token = token
    @bilgi = "PlusAPI | Piyasa Verileri Sınıfı"
  end

  def istek_at(endpoint, sembol = "")
    begin
      api = "http://plusapi.org/api" + endpoint + "?token=" + @token + ("&sembol=#{sembol}" if sembol != "").to_s
      uri = URI(api)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        return JSON.parse(res.body)
      else
        return {
          error => "Bir hata oluştu sayfa boş döndü"
        }
      end
    rescue Errno::ECONNREFUSED
      return {
        error => "Sembol bulunamadı ya da bir hata oluştu",
        code => 500
      }
    end
  end

  def hisse_ver(sembol = "")
    istek = istek_at("/hisse", sembol)
    return istek
  end

  def hisse_sepet()
    istek = istek_at("/hisse/sepet")
    return istek
  end

  def kripto_ver(sembol = "")
    istek = istek_at("/kripto", sembol)
    return istek
  end

  def kripto_haber()
    istek = istek_at("/kripto/haber")
    return istek
  end

  def kripto_sepet()
    istek = istek_at("/kripto/sepet")
    return istek
  end
end