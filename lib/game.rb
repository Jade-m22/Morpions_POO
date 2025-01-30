class Game
  attr_accessor :current_player, :status, :board, :players
  
  def initialize
    puts "Joueur 1, entrez votre nom :"
    name1 = gets.chomp
    puts "Joueur 2, entrez votre nom :"
    name2 = gets.chomp
  
    @players = [Player.new(name1, "❤️"), Player.new(name2, "🩵")]
    @current_player = @players[0]
    @status = "en cours"
    @board = Board.new
  end


  def turn 
    while @status == "en cours" do
      board.show_board
      board.play_turn(@current_player)
      winner = board.victory?
  
      if winner == "nul"
        @status = "nul"
      elsif winner
        @status = winner
      else
        # Change de joueur
        @current_player = @current_player == @players[0] ? @players[1] : @players[0]
      end
    end
  
    game_end if @status != "en cours"
  end
  


  def new_round
    # TO DO : relance une partie en initialisant un nouveau board mais en gardant les mêmes joueurs.
    @board = Board.new
    @current_player = @players[0]
    @board.count_turn = 0
    @status = "en cours"
  end

  def game_end
    if @status == "nul"
      puts "Match nul !"
    else
      winner = @players.find { |player| player.symbol == @status }
      puts "Bravo #{winner.name} a gagné !"
    end
    loop do
      puts "Voulez-vous jouer une nouvelle partie ? (oui/non)"
      answer = gets.chomp.downcase
      if answer == "oui"
        new_round
        turn
        break
      elsif answer == "non"
        puts "Merci d'avoir joué !"
        break
      else
        puts "Réponse invalide, veuillez répondre par 'oui' ou 'non'."
      end
    end
  end
end