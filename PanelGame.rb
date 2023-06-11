#Create a 3x3 grid
grid = Array.new(3) {Array.new(3)}

#Fill the grid with random Xs and 0s
symbols = ['X', 'O']
grid.each do |row|
  row.map! {symbols.sample}
end


#Display the initial grid
grid.each do |row|
  puts row.join(' ')
end

def press_panel(grid, row, col)
  #Check if the panel is already pressed
  return if grid[row][col].nil?

  #Press the press_panel
  symbol = grid[row][col]
  grid[row][col] = nil

  #Update adjacent panels
  adjacent_positions = [[row-1, col], [row+1, col], [row, col-1], [row, col+1]]
  adjacent_positions.each do |adj_row, adj_col|
    next if adj_row < 0 || adj_row >= grid.length || adj_col < 0 || adj_col >= grid[0].length

    if grid[adj_row][adj_col] == symbol
      press_panel(grid, adj_row, adj_col)
    else
      grid[adj_row][adj_col] = symbol unless grid[adj_row][adj_col].nil?
    end
  end
end


#Player interaction
loop do
  puts "Enter the row and column indices of the panel you want to press (separated by a space):"
  input = gets.chomp
  row, col = input.split.map(&:to_i)

  if row < 0 || row >= grid.length || col < 0 || col >= grid[0].length
    puts "invalid panel position! Please try again."
    next
end

press_panel(grid, row, col)

#Displa the updated grid
grid.each do |row|
  puts row.map { |symbol| symbol.nil? ? ' ': symbol}.join(' ')
end

#Check if all panels are the sample
if grid.flatten.uniq.compact.length == 1
  puts "Congratulations! You have won the game."
  break
end
end
