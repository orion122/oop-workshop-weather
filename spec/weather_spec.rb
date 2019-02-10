RSpec.describe Weather do
  class Service
    def self.make_request(city)
      {
        'city': city,
        'forecast': '+25'
      }
    end
  end

  before do
    weather = Weather::Weather.new(
      'my_service',
      { 'my_service'=> Service }
    )
    @city = 'Moscow'
    @request = weather.get_info(@city)
  end

  describe '#get_info' do
    context 'pass new service' do
      it_is_asserted_by { expect(@request).to eq(Service.make_request(@city)) }
    end
  end
end
