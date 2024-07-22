require 'spec_helper'

feature "Paralysing" do
  scenario "Paralyse Player 2 and get a confirmation" do
    sign_in_and_play
    allow(Game.instance.target_player).to receive(:missing_turn).and_return(true)
    click_button "Paralyse Timmy"
    expect(page).to have_content("Dave paralysed Timmy")
  end

  scenario "Paralyse Player 2 and get a failure message" do
    sign_in_and_play
    allow(Game.instance.target_player).to receive(:missing_turn).and_return(false)
    click_button "Paralyse Timmy"
    expect(page).to have_content("Dave tried to paralyse Timmy but failed")
  end
end
