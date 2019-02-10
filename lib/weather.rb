require 'weather/version'
require 'net/http'
require 'json'


module Weather
  class Weather
    SERVICES = {
      'first'=> 'https://www.metaweather.com/api/location/search/?query=',
      'second'=> 'http://api.apixu.com/v1/forecast.json?key=be33701f8d2a4beeae864603191002&q='
    }

    attr_reader :service_url

    def initialize(service: 'first')
      @service_url = SERVICES[service]
    end

    def get_info(city: 'moscow')
      uri = URI(@service_url + city)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end

    # def first_service_query(city)
    #   SERVICES['first'] + city
    # end
    #
    # def second_service_query(city)
    #   SERVICES['second'] + city
    # end
  end
end
