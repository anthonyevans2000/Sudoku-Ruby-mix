#A class to define a sudoku board and methods to operate on it

class SudokuBoard
  attr_accessor :print, :valid, :list, :deep_copy, :available_positions
  attr_reader :board
       
      
  def initialize
    #Returns a 9x9 sudoku board, made of of 9 arrays of length nine.
    @depth = 0
    @board = []
    9.times{@board << Array.new(9)}
  end
    
  def print(board)
      board.each do |line|
      puts line.join
    end
  end
    
  def boardwrite(x,y,val,board)
    temp = board[y]
    temp[x] = val
    board[y] = temp
  end
    
  def boardread(x,y,board)
    temp = board[y]
    temp[x]
  end
    
  #returns sub box of 0-indexed board position
  def return_sub_box(x,y,board)
    box = [] 
    board[((y/3)*3)..(((y/3)*3)+2)].each{|row| box << row[((x/3)*3)..(((x/3)*3)+2)].dup}
    box
  end
    
  #Returns an array of values that a 0-indexed position on @board can be filled with
  def return_valid_values(x,y,board)
    occur = []
    valid = (1..9).to_a
    #Sweeps row
    occur = board[y].compact
    #Sweeps column
    occur << board.transpose[x].compact
    #Sweeps box
    occur << return_sub_box(x,y,board).flatten.compact
    #Deletes values that appear in same row or column
    valid = valid - occur.flatten
  end   

  def available_positions(board)
    least = []
    (0..8).each do |x|
      (0..8).each do |y|
        if not boardread(x,y,board)
          least << [x,y,return_valid_values(x,y,board)]
        end
      end
    end
    output = []
    least.each{|x,y,z| output << [x , y, z, z.length]}
    output.sort!{|x,y| x[3] <=> y[3]}
    output
  end
  
  def recursive_fill(board)
    positions = available_positions(board)
    if positions == []
      return board
    elsif
      positions[0][3] == 0
      return false
    else
      x = positions[0][0]
      y = positions[0][1]
      values = positions[0][2].shuffle
      test_board = deep_copy(board)
      begin
      if(values == []) then return false end
      val = values.pop
      boardwrite(x,y,val,test_board)
      end while !(o = recursive_fill(test_board))
      return o
    end
  end

  def deep_copy(array)
    new_array = []
    array.each do |x|
      if x.is_a?(Array)
        new_array << deep_copy(x)
      else
        new_array << x
      end
    end
    new_array
  end

end
