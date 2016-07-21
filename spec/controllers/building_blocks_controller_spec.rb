require 'rails_helper'

RSpec.describe BuildingBlocksController, type: :controller do
  describe "building_blocks#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
