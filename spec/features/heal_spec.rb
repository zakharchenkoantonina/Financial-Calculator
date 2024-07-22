require 'spec_helper'

feature "Healing" do
  scenario "Player 1 can heal and get a confirmation" do
    sign_in_and_play
    click_button "Heal Dave"
    expect(page).to have_content("Dave healed himself")
  end

  scenario "Heal and display new HP" do
    sign_in_and_play
    allow(Game.instance.current_player).to receive(:random_heal).and_return(15)
    click_button "Heal Dave"
    expect(page).to have_content("Dave HP: 115")
  end
end
