RSpec.describe Weather do
  CITY = 'Moscow'

  CITY_INFO = {
    'city'=> CITY,
    'forecast'=> '+25'
  }

  class HttpClient
    def get(uri)
      url_response = {
        "www.metaweather.com/api/location/search/query=#{CITY}"=> '[{"woeid":1}]',
        "www.metaweather.com/api/location/1/"=> CITY_INFO.to_json,
        "api.apixu.com/v1/forecast.jsonkey=&q=#{CITY}"=> CITY_INFO.to_json
      }
      url_response["#{uri.host}#{uri.path}#{uri.query}"]
    end
  end

  service1 = Weather::Metaweather.new(http_client: HttpClient.new)
  service2 = Weather::Apixu.new(http_client: HttpClient.new)

  before do
    @weather1 = Weather::Weather.new(
      service_name: 'my_service1',
      services: { 'my_service1'=> service1 }
    )
    @weather2 = Weather::Weather.new(
      service_name: 'my_service2',
      services: { 'my_service2'=> service2 }
    )
    @city_info1 = @weather1.get_info(CITY)
    @city_info2 = @weather2.get_info(CITY)
  end


  describe '#get_info' do
    context 'pass first service' do
      it_is_asserted_by { @city_info1 == CITY_INFO }
    end
    context 'pass second service' do
      it_is_asserted_by { @city_info2 == CITY_INFO }
    end
  end
end
