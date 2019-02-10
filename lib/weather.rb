require 'weather/version'
require 'net/http'
require 'json'


module Weather
  class Metaweather
    URL = 'https://www.metaweather.com/api/location/search/?query='

    def make_request(city)
      uri = URI(URL + city)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end


  class Apixu
    URL = 'http://api.apixu.com/v1/forecast.json?key=be33701f8d2a4beeae864603191002&q='

    def make_request(city)
      uri = URI(URL + city)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end


  class Weather
    SERVICES = {
      'metaweather' => ::Weather::Metaweather.new,
      'apixu' => ::Weather::Apixu.new
    }

    def initialize(service_name)
      @service = SERVICES[service_name]
    end

    def get_info(city)
      @service.make_request(city)
    end
  end
end
