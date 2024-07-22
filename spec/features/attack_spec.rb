require 'spec_helper'

feature "Attacking" do
  scenario "Attack Player 2 and get a confirmation" do
    sign_in_and_attack
    expect(page).to have_content("Dave attacked Timmy")
  end

  scenario "Player 2 loses HP when attacked" do
    sign_in_and_play
    allow(Game.instance.target_player).to receive(:random_damage).and_return(10)
    click_button "Attack Timmy"
    expect(page).not_to have_content("Timmy HP: 100")
    expect(page).to have_content("Timmy HP: 90")
  end

  context "Player1 attacks first, then player2 attacks" do
    scenario "Player 1 loses HP" do
      sign_in_and_attack
      click_button "OK"
      allow(Game.instance.target_player).to receive(:random_damage).and_return(10)
      click_button "Attack Dave"
      expect(page).not_to have_content("Dave HP: 100")
      expect(page).to have_content("Dave HP: 90")
    end

    scenario "Attack player1 and get confirmation" do
      sign_in_and_attack_both
      expect(page).to have_content("Timmy attacked Dave")
    end
  end
end
