RSpec.describe Weather do
  before do
    CITY = 'Moscow'

    CITY_INFO = {
      'city': CITY,
      'forecast': '+25'
    }

    class Service
      def make_request(city)
        CITY_INFO
      end
    end

    @weather = Weather::Weather.new(
      'my_service',
      { 'my_service'=> Service.new }
    )

    @city_info = @weather.get_info(CITY)
  end


  describe '#get_info' do
    context 'pass new service' do
      it_is_asserted_by { @city_info == CITY_INFO }
    end
  end
end
