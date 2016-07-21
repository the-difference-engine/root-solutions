require 'rails_helper'
require 'spec_helper'

feature "User edits a resource" do
  scenario "should successfully updates with all valid criteria" do
    FactoryGirl.create(:resource)
    visit "/resources"
    click_link "Edit"

    fill_in "Title", with: "Happy Edited News"

    click_on "Update Resource"

    expect(page).to have_content("Happy Edited News")
  end
  scenario "shouldn't successfully update resource without the valid criteria" do

  end
end
