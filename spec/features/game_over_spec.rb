require 'spec_helper'

feature "GAME_OVER" do
  scenario "Player 2 is attacked until dead" do
    sign_in_and_play
    allow(Game.instance.player1).to receive(:random_damage).and_return(10)
    allow(Game.instance.player2).to receive(:random_damage).and_return(10)
    attack_9_times
    click_button 'Attack Timmy'
    expect(page).to have_content("GAME OVER - Timmy has died!")
    expect(page).not_to have_css("form")
  end
end
