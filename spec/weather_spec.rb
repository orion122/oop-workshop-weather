RSpec.describe Weather do
  let(:city) { 'Moscow' }

  class Service
    def self.make_request(city)
      {
        'city': city,
        'forecast': '+25'
      }
    end
  end

  let(:weather) {
    Weather::Weather.new(
      'my_service',
      { 'my_service'=> Service })
  }

  describe '#get_info' do
    context 'pass new service' do
      subject { weather.get_info(city) }
      it { is_expected.to eq(Service.make_request(city)) }
    end
  end
end
