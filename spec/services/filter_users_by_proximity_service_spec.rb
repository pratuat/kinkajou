require './spec/spec_helper'

RSpec.describe FilterUsersByProximityService do

  subject { FilterUsersByProximityService.new(user_locations)}

  let(:user_locations) {
    open('./spec/fixtures/test_customers.json').readlines.map {|line| JSON.parse(line)}
  }

  describe '#call' do
    it 'returns list of customers filtered by proximity' do
      expect(subject.call()).to match_array([
        {'user_id' => 4, 'name' => "Ernesto Breitenberg"},
        {'user_id' => 16, 'name' => "Prof. Antoine Sporer"},
      ])
    end
  end

  describe '#geodesic_distance' do
    it 'returns geodesic distance of input (lat, lon) from TARGET_LOCATION' do
      expect(subject.geodesic_distance(51.42, 15.02)).to eq(75.83342367580273)
    end
  end
end