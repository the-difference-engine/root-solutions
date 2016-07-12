require 'rails_helper'

describe AdminsController do
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect {
          post :create, params: {email: "admin@admin.com", password: "password"}
        }.to change(User, :count).by(1)
      end
    end
  end
end