#A class to define a sudoku board and methods to operate on it

class SudokuBoard(
  attr_accessor :board 
  
  

  def initialize(size)
    @board = []
    @board = (size*3).times{@board << Array.new(size*3)}
    values = (1..(size*3)).to_a
    @valid_values = (size*3).times{@valid_values << values.dup}    
  end

 # def return_valid_value(x,y)
    

      
  
