require 'rails_helper'

describe BackgroundsFacade, :vcr do
  describe "class methods" do
    it "get_background" do
      background = BackgroundsFacade.get_background("Denver, CO")

      expect(background).to be_a(Background)
    end
  end
end
