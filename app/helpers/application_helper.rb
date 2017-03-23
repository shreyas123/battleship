module ApplicationHelper
  def game(game_id)
    @game ||= Game.find_by(id: game_id)
    halt 400, json({error: 'Game does not exist'}) unless @game
  end
end