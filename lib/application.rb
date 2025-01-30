class Application
  def perform
    game = Game.new
    game.turn
  end
end
