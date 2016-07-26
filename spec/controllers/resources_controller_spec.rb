require 'rails_helper'
require 'spec_helper'

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
  describe "user deletes a resource" do
    it "should successfully delete resource" do
      resource = FactoryGirl.create(:resource)
      expect{
        delete :destroy, id: resource
        }.to change(Resource, :count).by(-1)
    end
  end
end
