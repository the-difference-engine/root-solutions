require 'rails_helper'

RSpec.describe Resource do
    it { should have_many :attachments }

    before(:each) {
        @resource = FactoryGirl.create(:resource)
    }

    describe "attachments" do

        it "should have multiple attachments" do

            @resource.attachments.create({url:File.open(File.join(Rails.root, '/spec/fixtures/files/image.png'))})
            @resource.attachments.create({url:File.open(File.join(Rails.root, '/spec/fixtures/files/image.png'))})

            @resource.attachments.length.should eq(3)
        end
    end


end