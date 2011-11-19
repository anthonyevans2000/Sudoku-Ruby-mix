 
#Test functions

#Gives an array of unused values for dynamic programming purposes.
    @valid = []
    9.times{@valid << (0..8).to_a}
    @valid.each do |y|
      y.each do |x| 
        y[x] = (1..9).to_a
      end
    end
    
    #Consider the idea of a list, that is an x-y lookup, sortable via remaining val's
    @list = []
    (0..8).each do |y|
      (0..8).each do|x|
       @list << [x , y , @valid[x][y]]
      end
    end

 Some code for the implementation of a list structure for dynamic programming

  def sweep_valid_values
    index = 0
    @list.each do |x|
      @list[index][2] = return_valid_values(x[0],x[1])
      @list[index][3] = @list[index][2].length
      index = index+1
    end
  end  
  
  def sort_value_list
    @list.sort!{|x,y| x[3] <=> y[3]}
  end  
 i 
  def insert_from_list
    sort_value_list
    position = @list.pop
    x = position[0]
    y = position[1]
    valid = position[2].compact
    boardwrite(x,y,valid.shuffle.pop)
  end  
