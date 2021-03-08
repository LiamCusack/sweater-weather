require 'rails_helper'

describe 'Forecast Api' do
  it 'this is a test' do
    VCR.turn_off!
    WebMock.allow_net_connect!
    get '/api/v1/forecast?location=1600 sagrimore circle lafayette co'
  end
end
