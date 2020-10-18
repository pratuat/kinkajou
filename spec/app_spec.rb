require 'spec_helper'
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'GET dashboard' do
    it 'returns dashbaord' do
      get '/'

      expect(last_response.status).to eq 200
    end
  end

  describe 'POST filter customers' do
    it 'returns customers filtered by distance' do
      post '/filter_customers', file: Rack::Test::UploadedFile.new('./spec/fixtures/customers.json')

      expect(last_response.status).to eq 200
      expect(last_response.body).to eq 'Success'
    end
  end
end
