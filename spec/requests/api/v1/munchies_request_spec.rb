require 'rails_helper'

describe 'Munchies request' do
  it 'can successfully call the api' do
    VCR.turn_off!
    WebMock.allow_net_connect!
    get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'
  end
end
