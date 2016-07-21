require 'rails_helper'
require 'spec_helper'

feature "User posts a resource" do
  scenario "should successfully post with all valid criteria" do
    visit "/resources"
    click_link "New Resource"
    sleep(2)
    fill_in "World region", with: "USA"
    fill_in "Title", with: "Happy News"
    fill_in "Author", with: "Anna"
    fill_in "News source", with: "CNN"
    fill_in "Date", with: "01/01/2016"
    fill_in "Summary", with: "Happy summary"
    fill_in "Url", with: "happy.com"
    fill_in "Notes", with: "Cheer up"
    click_on "Create Resource"

    expect(page).to have_content("Happy News")
  end
  scenario "shouldn't successfully post resource without the valid criteria" do

  end
end
