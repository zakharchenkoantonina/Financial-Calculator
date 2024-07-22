require_relative 'game'

class Player
  attr_reader :name, :hit_points, :missing_turn, :poisoned

  DEFAULT_HP = 100

  def initialize(name, hit_points = DEFAULT_HP)
    @name = name
    @hit_points = hit_points
    @missing_turn = false
    @poisoned = false
  end

  def dead?
    hit_points <= 0
  end

  def receive_damage
    @hit_points -= random_damage
  end

  def paralyse
    @hit_points -= (random_damage/2)+5
    @missing_turn = (1..3).include?(random_chance)
  end

  def sleep
    @hit_points -= (random_damage/4)+5
    @missing_turn = (1..6).include?(random_chance)
  end

  def become_poisoned
    @poisoned = true
  end

  def poison_damage
    @hit_points -= random_damage / 5
  end

  def heal
    @hit_points += random_heal
  end

  def random_heal
    rand(5..20)
  end

  def random_chance
    rand(1..10)
  end

  def random_damage
    rand(10..30)
  end
end
