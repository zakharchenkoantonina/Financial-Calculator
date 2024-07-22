require 'sinatra/base'

require './lib/player'
require './lib/game'

class Battle < Sinatra::Base

  enable :sessions

  before { @game = Game.instance }

  get '/' do
    erb(:index)
  end

  post '/names' do
    hero = params[:hero]
    villain = params[:villain]
    Game.create(Player.new(hero),Player.new(villain))
    redirect '/play'
  end

  get '/play' do
    erb(:play)
  end

  get '/attack' do
    @last_move = @game.attack_current_target
    @target_hp = @game.target_hp
    redirect('/game_over') if @game.over?

    if @game.auto?
      @game.switch
      @next_move = @game.attack_current_target
      @next_hp = @game.target_hp
    end

    @game.over? ? redirect('/game_over') : erb(:attack)
  end

  get '/paralyse' do
    @last_move = @game.paralyse_current_target
    @target_hp = @game.target_hp
    redirect('/game_over') if @game.over?

    if @game.target_player.missing_turn
      @next_move = "#{@game.target_player.name} is paralysed."
      @game.switch
    end

    erb(:attack)
  end

  get '/sleep' do
    @last_move = @game.sleep_current_target
    @target_hp = @game.target_hp
    redirect('/game_over') if @game.over?

    if @game.target_player.missing_turn
      @next_move = "#{@game.target_player.name} is sleeping."
      @game.switch
    end

    erb(:attack)
  end

  get '/poison' do
    @last_move = @game.poison_current_target
    @target_hp = @game.target_hp
    erb(:attack)
  end

  get '/heal' do
    @last_move = @game.heal_current_player
    @target_hp = @game.current_hp
    erb(:attack)
  end

  post '/attack' do
    @game.target_player.poison_damage if @game.target_player.poisoned 
    @game.switch
    redirect '/play'
  end

  get '/game_over' do
    erb(:game_over)
  end


  run! if app_file == $0
end
