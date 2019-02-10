RSpec.describe Weather do
  before do
    CITY = 'Moscow'

    CITY_INFO = {
      'city': CITY,
      'forecast': '+25'
    }

    class HttpClient
      def get(url)
        CITY_INFO
      end
    end

    class Service
      def initialize(http_client: http_client)
        @http_client = http_client
      end

      def make_request(city)
        @http_client.get("q=#{city}")
      end
    end


    @weather = Weather::Weather.new(
      service_name: 'my_service',
      services: { 'my_service'=> Service.new(http_client: HttpClient.new) }
    )

    @city_info = @weather.get_info(CITY)
  end


  describe '#get_info' do
    context 'pass new service' do
      it_is_asserted_by { @city_info == CITY_INFO }
    end
  end
end
