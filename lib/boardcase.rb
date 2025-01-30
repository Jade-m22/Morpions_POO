class BoardCase 
  attr_accessor :id, :value

  def initialize(position)
    @id = position #numéro de case
    @value = " " #valeur X ou O 
  end 

end