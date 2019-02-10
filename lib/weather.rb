require 'weather/version'
require 'open-uri'
require 'json'


module Weather
  class Metaweather
    URL = 'https://www.metaweather.com/api'

    def make_request(city)
      location_id = get_location_id(city)
      response = open("#{URL}/location/#{location_id}").read
      JSON.parse(response)
    end

    def get_location_id(city)
      response = open("#{URL}/location/search/?query=#{city}").read
      JSON.parse(response)[0]['woeid']
    end
  end


  class Apixu
    URL = 'http://api.apixu.com/v1/forecast.json?key=be33701f8d2a4beeae864603191002&q='

    def make_request(city)
      response = open("#{URL}#{city}").read
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
