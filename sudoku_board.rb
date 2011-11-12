#A class to define a sudoku board and methods to operate on it

class SudokuBoard
  attr_accessor :print, :valid_values
  attr_reader :board
  
  
  def initialize
    #Returns a 9x9 sudoku board, make of of 9 arrays of length nine.
    @board = []
    9.times{@board << Array.new(9)}
  end

  def print
    @board.each do |line|
      puts line.join
    end
  end
  
  def boardwrite(x,y,val)
    temp = @board[y]
    temp[x] = val
    @board[y] = temp
  end

  def boardread(x,y)
    temp = @board[y]
    temp[x]
  end


  #returns sub box of 0-indexed board position
  def return_sub_box(x,y)
    box = [] 
    @board[((y/3)*3)..(((y/3)*3)+2)].each{|row| box << row[((x/3)*3)..(((x/3)*3)+2)].dup}
    box
  end

  #Returns an array of values that a 0-indexed position on @board can be filled with
  def return_valid_values(x,y)
  occur = []
  valid = (1..9).to_a
  #Sweeps row
  occur = @board[y].compact
  #Sweeps column
  occur << @board.transpose[x].compact
  #Sweeps box
  occur << return_sub_box(x,y).flatten.compact
  #Deletes values that appear in same row or column
  valid = valid - occur.flatten
  end   
  
  def get_position_with_least_options
  least = []
  least[0] = nil
  least[1] = nil
  least_length = 10
  (0..8).each do |x|
    (0..8).each do |y|
      if (return_valid_values(x,y).length < least_length) && (not (boardread(x,y)))
        least_length = return_valid_values(x,y).length
        least[0] = x
        least[1] = y
      end
    end
  end
  least
  end

  def fill_with_random_value
    position = get_position_with_least_options
    values = return_valid_values(position[0],position[1])
    boardwrite(position[0],position[1],values.shuffle.pop)
  end


end
      
  
