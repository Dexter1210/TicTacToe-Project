puts "Welcome to Tic Tac Toe!"
board=[["-","-","-"],["-","-","-"],["-","-","-"]]
#play(board)

def display_board(board)
    puts "#{board[0][0]} | #{board[0][1]} |#{board[0][2]}"
    puts "---------"
    puts "#{board[1][0]} | #{board[1][1]} |#{board[1][2]}"
    puts "---------"
    puts "#{board[2][0]} | #{board[2][1]} |#{board[2][2]}"
end

def input_to_index(user_input)
    user_input.to_i-1
end

def player_move(board,row,column,marker)
    board[row][column]=marker
end

def position_taken? (board,row,column)
    if board[row][column]=="-"
        return false
    else
        return true
    end
end

def valid_move?(board,row,column)
    if !position_taken?(board,row,column) && (row).between?(0,2) &&  (column).between?(0,2)
        return true
    else
        return false
    end
end

def current_player(board)
    turn_count(board)%2==0 ? "X" : "O"
end

def turn(board)
    puts "Please enter 1-9:"
    user_input=gets.strip
    index=input_to_index(user_input)
    if valid_move?(board,row,column)
        player_move(board,row,column,current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    counter=0
    board.each{|space| 
    if space=="X" || space=="O"
        counter+=1
    end
    }
    counter
end

WIN_COMBINATIONS=[
    [[0][0],[0][1],[0][2]],
    [[1][0],[1][1],[1][2]],
    [[2][0],[2][1],[2][2]],
    [[0][0],[1][0],[2][0]],
    [[0][1],[1][1],[2][1]],
    [[0][2],[1][2],[2][2]],
    [[0][0],[1][1],[2][2]],
    [[0][2],[1][1],[2][0]]

]

def won?(board)
    WIN_COMBINATIONS.each do|single_win_combo|
        win_index_1r=single_win_combo[0][0]
        win_index_1c=single_win_combo[0][1]
        win_index_2r=single_win_combo[1][0]
        win_index_2c=single_win_combo[1][1]
        win_index_3r=single_win_combo[2][0]
        win_index_3c=single_win_combo[2][1]

        position_1=board[win_index_1r][win_index_1c]
        position_2=board[win_index_2r][win_index_2c]
        position_3=board[win_index_3r][win_index_3c]

        if position_1==position_2 && position_2 == position_3 && position_taken?(board, win_index_1r,win_index_1c)
            return single_win_combo
        end
    end
    return false
end

      def full?(board)
        if board.any? {|row,column| row == nil || row == "-" && column==nil || column=="-"}
          return false
        else
          return true
        end
      end
      
      def draw?(board)
         if !won?(board) && full?(board)
           return true
         elsif!full?(board) && !won?(board)
           return false
         else won?(board)
           return false
         end
      end
      
      def over?(board)
        if draw?(board) || won?(board) || full?(board) 
          return true
        else
          return false
        end
      end

      def winner(board)
        if won?(board)
          return board[won?(board)[0][0]]
        end
      end
      
      def play(board)
        counter = 0
        until counter == 9
        turn(board)
        counter += 1
        end
      end
      
      def play(board)
        until over?(board)
          turn(board) 
        end
        if won?(board)
          winner(board) == "X" || winner(board) == "O"
          puts "Congratulations #{winner(board)}!"
        else draw?(board)
          puts "Draw"
        end
      end

    play(board)