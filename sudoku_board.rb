#A class to define a sudoku board and methods to operate on it

class SudokuBoard
  attr_accessor :print, :valid, :list, :deep_copy, :available_positions
  attr_reader :board
       
      
  def initialize
    #Returns a 9x9 sudoku board, made of of 9 arrays of length nine.
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

  def available_positions
  least = []
  (0..8).each do |x|
    (0..8).each do |y|
      if not boardread(x,y)
        least << [x,y,return_valid_values(x,y)]
      end
    end
  end
  output = []
  least.each{|x,y,z| output << [x , y, z, z.length]}
  output.sort!{|x,y| x[3] <=> y[3]}
  end
  
  def fill_with_random_value
    position = available_positions
    x = position[0][0]
    y = position[0][1]
    values = position[0][2].dup
    while not boardread(x,y)
      values = values.shuffle
      boardwrite(x,y,values.pop)
      if 0 == available_positions[0][3]
        boardwrite(x,y,nil)
        if values.length == 0
          raise "Out of values, stuck in dead end!"
        end
      end
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
