require 'spec_helper'

feature "Naming Players" do
  scenario "Expects players to fill in their names" do
    sign_in_and_play
    expect(page).to have_content("Dave vs. Timmy")
  end
end
