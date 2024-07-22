require 'spec_helper'

describe Player do
  subject(:player) { Player.new('Dave') }

  describe '#name' do
    it 'returns its name' do
      expect(player.name).to eq('Dave')
    end
  end

  describe '#hit points' do
    it "returns the hitpoints " do
      expect(player.hit_points).to eq(Player::DEFAULT_HP)
    end
  end

  describe '#poisoned' do
    it 'equals false when initialized' do
      expect(subject.poisoned).to be false
    end
  end 

  describe '#receive damage' do
    it "reduces the player HP" do
      allow(player).to receive(:random_damage).and_return(10)
      expect { player.receive_damage }.to change {player.hit_points}.by(-10)
    end
  end

  describe '#random_damage' do
    it 'returns a random number between 10..30' do
      expect(10..30).to include(player.random_damage)
    end
  end

  describe '#dead?' do
    it "should return true if the player HP drops below 0" do
      10.times { player.receive_damage }
      expect(player).to be_dead
    end
  end

  describe '#heal' do
    it "should increase the player HP" do
      allow(player).to receive(:random_heal).and_return(15)
      expect { player.heal }.to change {player.hit_points}.by(15)
    end
  end

  describe '#random_heal' do
    it 'returns a random number between 5..20' do
      expect(5..20).to include(player.random_heal)
    end
  end

  describe '#poison' do

    describe '#become_poisoned' do
      it 'poisons the player' do
        subject.become_poisoned
        expect(subject.poisoned).to eq true
      end
    end

    describe '#poison_damage' do
      it 'removes random damage' do
        expect{subject.poison_damage}.to change{subject.hit_points}.by (-6..-2)
      end
    end
  end
end
