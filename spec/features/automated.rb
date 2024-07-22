require 'spec_helper'

feature "Automated Play" do
  scenario "Attack computer and get a confirmation" do
    sign_in_and_lonely_play
    click_button "Attack computer"
    expect(page).to have_content("Dave attacked computer")
    expect(page).to have_content("computer attacked Dave")
  end

  scenario "After attacking see both player and computers HP " do
    sign_in_and_lonely_play
    allow(Game.instance.target_player).to receive(:random_damage).and_return(10)
    click_button "Attack computer"
    expect(page).to have_content("computer HP: 90")
    expect(page).to have_content("Dave HP: 90")
  end
end
