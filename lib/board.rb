class Board
  attr_accessor :boardcases, :count_turn

  def initialize
    @count_turn = 0
    @boardcases = []
    ("A".."C").each do |row|
      (1..3).each do |col|
        @boardcases << BoardCase.new("#{row}#{col}")
      end
    end
  end

  def play_turn(current_player)
    #1) demande au bon joueur ce qu'il souhaite faire
    #2) change la BoardCase jouée en fonction de la valeur du joueur (X ou O)
    puts "#{current_player.name}, où souhaites-tu jouer ? (ex: A1, B3)" 
      choice = gets.chomp.upcase
      row = choice[0]
      col = choice[1]
      choice_case = @boardcases.find {|board_case| board_case.id == choice}
    if choice_case.value == " "
      choice_case.value = current_player.symbol
      @count_turn += 1
    else
      puts "La case est déjà prise"
      play_turn(current_player)

    end
  end  

  def show_board
    puts "   1    2    3 "
    puts "A #{@boardcases[0].value} | #{@boardcases[1].value}  | #{@boardcases[2].value}"
    puts "-"*15
    puts "B #{@boardcases[3].value} | #{@boardcases[4].value}  | #{@boardcases[5].value}"
    puts "-"*15
    puts "C #{@boardcases[6].value} | #{@boardcases[7].value}  | #{@boardcases[8].value}"
  end

  def victory?
    winning_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ]
      winning_combinations.each do |combinaison|
      values = combinaison.map { |index| @boardcases[index].value }
        if values.uniq.length == 1 && values.first != " "
          return values.first
        end
      end
        return "nul" if @count_turn == 9
  end
  # on crée un tableau (.map) values, on va chercher dans toutes les cases la valeur de l'index.
  # on vérifie si la longueur (.length) de la valeur de la ligne ou colonne est égale à 1, en supprimant les répétitions (avec .uniq). Donc si values = 1 on a un gagnant
  # le values.first != " " permet de ne pas déclarer de vaiqueur si 3 combinaisons gagnantes vides
end

