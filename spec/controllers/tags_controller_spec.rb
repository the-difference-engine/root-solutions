require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "tags#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
end
