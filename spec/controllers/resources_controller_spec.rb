require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe "grams#index action" do
     it "should successfully show the page" do
       get :index
       expect(response).to have_http_status(:success)
     end
   end
end
