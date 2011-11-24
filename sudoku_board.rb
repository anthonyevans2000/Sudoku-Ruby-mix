#A class to define a sudoku board and methods to operate on it

class SudokuBoard
  attr_accessor :board_read, :return_sub_box, :board_write #, :recursive_iterations
  attr_reader :board
       
      
  def initialize(size = 3)
    #Returns a 9x9 sudoku board, made of of 9 arrays of length nine.
    #@recursive_iterations = 0
    @num = size
    @size = size*size
    @board = []
    @size.times{@board << Array.new(@size)}
  end
    
  def print(board = @board)
    board.each do |line|
      puts line.join(' ')
    end
  end
  
  def clear
    initialize(@num)
  end

  def board_write(x,y,val,board = @board)
    temp = board[y]
    temp[x] = val
    board[y] = temp
  end
    
  def board_read(x,y,board = @board)
    temp = board[y]
    temp[x]
  end
    
  #returns sub box of 0-indexed board position
  def return_sub_box(x,y,board = @board)
    box = []
    y_access = (((y/@num)*@num)...(((y/@num)*@num)+@num))
    x_access = (((x/@num)*@num)...(((x/@num)*@num)+@num))
    board[y_access].each{|row| box << row[x_access].dup}
    box
  end
   
  def return_row y
  @board[y]
  end

  def return_column x
  @board.transpose[x]
  end
  
  #Returns an array of values that a 0-indexed position on @board can be filled with
  def return_valid_values(x,y,board = @board)
    occur = []
    valid = (1..@size).to_a
    #Sweeps row
    occur = board[y].compact
    #Sweeps column
    occur << board.transpose[x].compact
    #Sweeps box
    occur << return_sub_box(x,y,board).flatten.compact
    #Deletes values that appear in same row or column
    valid = valid - occur.flatten
  end   

  def available_positions(board = @board)
    least = []
    (0...@size).each do |x|
      (0...@size).each do |y|
        if not board_read(x,y,board)
          least << [x,y,return_valid_values(x,y,board)]
        end
      end
    end
    output = []
    least.each{|x,y,z| output << [x , y, z, z.length]}
    output.sort!{|x,y| x[3] <=> y[3]}
    output
  end
 
  def fill_recursively
    @board = recursive_fill
  end

  def recursive_fill(board = @board)
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
      board_write(x,y,val,test_board)

      #@recursive_iterations += 1
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
