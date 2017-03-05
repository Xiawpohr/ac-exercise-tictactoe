class TicTagToe
	attr_reader :board, :win_condition, :turn
	attr_accessor :player

	def initialize
		@board = [1,2,3,4,5,6,7,8,9]
		@win_condition = [
			[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]
		]
		@turn = 0
		@player = {'O' => [], 'X' => []}

	end

	def launch!
		introduction
		#action loop
		result = nil
		until result == :quit 
			puts "two_player or one_player or quit ?" 
			print "> "
			user_response = gets.chomp
			result = do_action(user_response)
		end
		conclusion
	end

	def do_action(action)
		case action
		when 'two_player'
			play(human_input,human_input)
		when 'one_player'
			play(human_input,computer_input)
		when 'quit'
			return :quit
		else
			puts "Do you want to play or quit?"
		end
	end

	def play(first, last)
		@turn = 0
		game_check = nil
		until game_check == :end 
			@turn += 1
			if @turn % 2 == 1 
				pos = first
				@player['O'] << pos
				@board.insert(pos-1,O)
			else 
				pos = last
				@player['X'] << pos
				@board.insert(pos-1,X)
			end
			game_display
			game_check = who_wins(@player)
		end
		puts "Do you want to play again ?"
	end

	def who_wins(player)
		if @turn == 9
			puts "No one wins the game."
			return :end
		end
		for i in 0...win_condition.size do
			if @player['O'] & win_condition[i] == win_condition[i]
				puts "O wins the game."
				return :end
			elsif @player['X'] & win_condition[i] == win_condition[i]
				puts "X wins the game."
				return :end
			else
				return nil
			end
		end
	end

	def human_input 
		position = nil
		until @board.include?(position) 
			puts "pick a number (position) to start"
			print "> "
			position_s = gets.chomp
			position = position_s.to_i
			@board.delete(position)
		end
		reutrn position
	end

	def computer_input
		# like an AI

	end

	def game_display
		puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
		puts "---------------------------------------"
		puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
		puts "---------------------------------------"
		puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
	end

	def introduction
		puts "<<  welcome to tic-tag-toe  >>"
		puts "The object of Tic Tac Toe is to get three in a row."
		puts "You play on a three by three game board."
		puts "The first player is known as O and the second is X."
		puts "Players alternate placing Xs and Os on the game board" 
		puts "until either oppent has three in a row or all nine squares are filled." 
		game_display	
	end

	def conclusion
		puts "<<  good bye  >>"
	end

end

game = TicTagToe.new
game.launch!