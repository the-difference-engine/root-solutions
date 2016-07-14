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

  describe "resources POST #create action" do
    it "should successfully create a new resource in the database" do
      post :create, resource: { world_region: "USA", title: "Happy News", author: "Anna",
       news_source: "CNN", date: "2016-01-01", summary: "Happy summary", url: "happy.com", notes: "Cheer up" }
      resource = Resource.last
      expect(response).to redirect_to "/resources/#{resource.id}"
      expect(resource.title).to eq("Happy News")
    end
  end
end
