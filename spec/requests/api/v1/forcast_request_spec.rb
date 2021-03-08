require 'rails_helper'

describe 'Forcast Api' do
  it 'this is a test' do
    get '/api/v1/forcast?location=1600 sagrimore circle lafayette co'
  end
end
