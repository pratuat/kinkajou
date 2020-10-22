require 'spec_helper'
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /' do

    let(:response) { get '/' }

    it 'returns http success' do
      expect(response.status).to eq 200
    end

    it 'displays a form to upload file to POST /' do
      expect(response.body).to have_tag(:form, with: { action: '/'}) do
        with_tag(:input, with: {type: 'file', name: 'file'})
      end
    end
  end

  describe 'POST /' do

    context 'when an invalid file is uploaded' do

      let(:response) { post '/', file: Rack::Test::UploadedFile.new('./spec/fixtures/invalid.json') }

      it 'returns http error' do
        expect(response.status).to eq 422
        expect(response.body).to match('Invalid file.')
      end
    end

    context 'when a valid file is uploaded' do

      let(:response) { post '/', file: Rack::Test::UploadedFile.new('./spec/fixtures/test_customers.json') }

      it 'returns http success' do
        expect(response.status).to eq 200
      end

      it 'displays a form to upload file to POST /' do
        expect(response.body).to have_tag(:form, with: { action: '/'}) do
          with_tag(:input, with: {type: 'file', name: 'file'})
        end
      end

      it 'displays filtered list of customers' do
        expect(response.body).to match(/Ernesto Breitenberg.*Prof. Antoine Sporer/)
        expect(response.body).not_to match(/Mary Pacocha III|Nathaniel Dicki|Lynne Wyman Esq./)
      end
    end
  end
end
