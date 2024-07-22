require 'spec_helper'

feature "Sleeping" do
  scenario "Sleep Player 2 and get a confirmation" do
    sign_in_and_play
    allow(Game.instance.target_player).to receive(:missing_turn).and_return(true)
    click_button "Sleep Timmy"
    expect(page).to have_content("Dave put Timmy to sleep")
  end

  scenario "Sleep Player 2 and get a failure message" do
    sign_in_and_play
    allow(Game.instance.target_player).to receive(:missing_turn).and_return(false)
    click_button "Sleep Timmy"
    expect(page).to have_content("Dave tried to put Timmy to sleep but failed")
  end
end
