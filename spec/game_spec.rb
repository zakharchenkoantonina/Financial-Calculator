require 'spec_helper'

describe Game do
  subject(:game) { Game.new(player1, player2) }

  let(:player1) { Player.new('Dave') }
  let(:player2) { Player.new('Timmy') }
  let(:computer) { Player.new(:computer) }

  describe '#player1' do
    it 'retrieves the first player' do
      expect(game.player1).to eq player1
    end
  end

  describe '#player2' do
    it 'retrieves the last player' do
      expect(game.player2).to eq player2
    end
  end

  describe '#auto?' do
    it 'should return a string "auto" if playing computer' do
      auto_game = described_class.new( player1, computer )
      expect(auto_game).to be_auto
    end
    it 'should return an empty string if not playing computer' do
      expect(game).not_to be_auto
    end
  end

  describe '#attack_current_target' do
    it "damages the player" do
      expect(player2).to receive(:receive_damage)
      game.attack_current_target
    end

    it "should set the game to GAME OVER if the target player dies" do
      10.times { game.attack_current_target }
      expect(game).to be_over
    end

    it "should return the attack confirmation" do
      expect(game.attack_current_target).to eq "#{player1.name} attacked #{player2.name}"
    end
  end

  describe '#heal_current_player' do
    it "heals the current player" do
      expect(player1).to receive(:heal)
      game.heal_current_player
    end

    it "should return the heal confirmation" do
      expect(game.heal_current_player).to eq "#{player1.name} healed himself"
    end
  end

  describe '#paralyse_current_target' do
    it "damages and tries to paralyse the player" do
      expect(player2).to receive(:paralyse)
      game.paralyse_current_target
    end

    it "should set the game to GAME OVER if the target player dies" do
      20.times { game.paralyse_current_target }
      expect(game).to be_over
    end

    it "should return the paralysing confirmation" do
      allow(game.target_player).to receive(:missing_turn).and_return(true)
      expect(game.paralyse_current_target).to eq "#{player1.name} paralysed #{player2.name}"
    end

    it "should return the missed paralyse confirmation" do
      allow(game.target_player).to receive(:missing_turn).and_return(false)
      expect(game.paralyse_current_target).to eq "#{player1.name} tried to paralyse #{player2.name} but failed"
    end
  end

  describe '#over?' do
    it "should be false by default" do
      expect(game).not_to be_over
    end
  end

  describe '#target_player' do
    it 'has player 2 as target player by default' do
      expect(subject.target_player).to eq player2
    end
  end

  describe '#current_player' do
    it 'has player 1 as target player by default' do
      expect(subject.current_player).to eq player1
    end
  end

  describe '#switch' do
    it 'switches the target player' do
      subject.switch
      expect(subject.target_player).to eq player1
    end
    it 'should switch target back to player2 when using twice' do
      subject.switch
      subject.switch
      expect(subject.target_player).to eq player2
    end
  end

  describe '#poison_current_target' do
    it 'poisons the current target' do
      allow(player1).to receive(:poisoned).and_return true
      subject.poison_current_target
      expect(player1.poisoned).to eq true
    end
  end
end
