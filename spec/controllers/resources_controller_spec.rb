require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe "resources GET #index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "resources GET #new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
