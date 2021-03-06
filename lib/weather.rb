require 'weather/version'
require 'net/http'
require 'json'


module Weather
  class Metaweather
    HOST = 'www.metaweather.com'

    attr_reader :http_client

    def initialize(http_client: Net::HTTP, key: '')
      @http_client = http_client
    end

    def make_request(city)
      location_id = get_location_id(city)
      uri = URI::HTTPS.build(
        host: HOST,
        path: "/api/location/#{location_id}/"
      )
      response = http_client.get(uri)
      JSON.parse(response)
    end

    def get_location_id(city)
      uri = URI("https://#{HOST}/api/location/search/?query=#{city}")
      response = http_client.get(uri)
      JSON.parse(response).first['woeid']
    end
  end


  class Apixu
    URL = 'http://api.apixu.com/v1/forecast.json?key='

    attr_reader :http_client, :key

    def initialize(http_client: Net::HTTP, key: '')
      @http_client = http_client
      @key = key
    end

    def make_request(city)
      uri = URI("#{URL}#{key}&q=#{city}")
      response = http_client.get(uri)
      JSON.parse(response)
    end
  end


  class Weather
    def initialize(service_name: service_name, key: '', services: {})
      services = services_map(key).merge(services)
      @service = services[service_name]
    end

    def get_info(city)
      @service.make_request(city)
    end

    def services_map(key)
      {
        'metaweather' => ::Weather::Metaweather.new(key: key),
        'apixu' => ::Weather::Apixu.new(key: key)
      }
    end
  end
end
