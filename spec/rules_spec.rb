# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#check_horizontal_streak' do
    context 'when there is three ♦ in a row and called from the end' do
      # End would mean the ♦ placed farthest to the right

      subject(:game_streak) { described_class.new }
      let(:row) { 5 }
      let(:column) { 2 }
      let(:symbol) { '♦' }
      before do
        game_streak.board[5][2] = '♦'
        game_streak.board[5][1] = '♦'
        game_streak.board[5][3] = '♦'
      end

      it 'returns 3' do
        expect(game_streak.check_horizontal_streak(row, column, symbol)).to eq(3)
      end
    end

    context 'when there is four ♦ in a row and called from the middle' do
      subject(:game_streak) { described_class.new }
      let(:row) { 5 }
      let(:column) { 1 }
      let(:symbol) { '♦' }
      before do
        game_streak.board[5][2] = '♦'
        game_streak.board[5][1] = '♦'
        game_streak.board[5][3] = '♦'
        game_streak.board[5][4] = '♦'
      end
      it 'returns 4' do
        expect(game_streak.check_horizontal_streak(row, column, symbol)).to eq(4)
      end
    end

    context 'when there is five ♦ in a row and called from the beginning of the board' do
      # Beginning of the board is (5, 0)
      subject(:game_streak) { described_class.new }
      let(:row) { 5 }
      let(:column) { 0 }
      let(:symbol) { '♦' }
      before do
        game_streak.board[5][2] = '♦'
        game_streak.board[5][1] = '♦'
        game_streak.board[5][3] = '♦'
        game_streak.board[5][4] = '♦'
        game_streak.board[5][0] = '♦'
      end

      it 'returns 5' do
        expect(game_streak.check_horizontal_streak(row, column, symbol)).to eq(5)
      end
    end
    context 'when there is three ♦ and one ♢ in a row' do
      subject(:game_streak) { described_class.new }
      let(:row) { 5 }
      let(:column) { 2 }
      let(:symbol) { '♦' }
      before do
        game_streak.board[5][2] = '♦'
        game_streak.board[5][1] = '♦'
        game_streak.board[5][3] = '♦'
        game_streak.board[5][4] = '♢'
      end
      it 'returns 3' do
        expect(game_streak.check_horizontal_streak(row, column, symbol)).to eq(3)
      end
    end
  end

  describe '#check_vertical_streak' do
    # We are always going to be calling from the highest when checking vertically
    let(:symbol) { '♦' }

    # Symbols will stack on top of eachother
    # Number of symbols in a column is the number of times the loop occurs
    context 'when there is four ♦ in a column' do
      subject(:game_streak) { described_class.new }
      let(:row) { 2 }
      let(:column) { 0 }
      before do
        4.times { game_streak.add_symbol(0, '♦') }
      end

      it 'returns 4' do
        expect(game_streak.check_vertical_streak(row, column, symbol)).to eq(4)
      end
    end

    context 'when there are three ♦ and two ♢ under in a column' do
      subject(:game_streak) { described_class.new }
      let(:row) { 1 }
      let(:column) { 0 }
      before do
        2.times { game_streak.add_symbol(0, '♢') }
        3.times { game_streak.add_symbol(0, '♦') }
      end
      it 'returns 3' do
        expect(game_streak.check_vertical_streak(row, column, symbol)).to eq(3)
      end
    end

    context 'when ehere is one ♦ in a column' do
      subject(:game_streak) { described_class.new }
      let(:row) { 5 }
      let(:column) { 0 }
      before { game_streak.add_symbol(0, '♦') }

      it 'returns 1' do
        expect(game_streak.check_vertical_streak(row, column, symbol)).to eq(1)
      end
    end
  end

  # For diagonal cases there is going to have to be two checks the symbols going up and down
  describe '#check_diagonal_streak_up' do
    context 'when there are four ♦ going up diagonaly' do
      subject(:game_diagonal_four) { described_class.new }
      let(:symbol) { '♦' }
      before do
        game_diagonal_four.board[5][0] = '♦'
        game_diagonal_four.board[4][1] = '♦'
        game_diagonal_four.board[3][2] = '♦'
        game_diagonal_four.board[2][3] = '♦'

      end

      context 'and called in the beginning' do
        let(:row) { 5 }
        let(:column) { 0 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_up(row, column, symbol)).to eq(4)
        end
      end

      context 'and called in the middle' do
        let(:row) { 4 }
        let(:column) { 1 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_up(row, column, symbol)).to eq(4)
        end
      end

      context 'and called in the end' do
        # End here is the ♦ farthest to the right
        let(:row) { 2 }
        let(:column) { 3 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_up(row, column, symbol)).to eq(4)
        end
      end

      context 'when there are three ♦ going up diagnoal and one ♢ at the end' do
        subject(:game_diagonal_three) { described_class.new }
        let(:symbol) { '♦' }
        let(:row) { 5 }
        let(:column) { 0 }

        before do
          game_diagonal_three.board[5][0] = '♦'
          game_diagonal_three.board[4][1] = '♦'
          game_diagonal_three.board[3][2] = '♦'
          game_diagonal_three.board[2][3] = '♢'
        end

        it 'returns 3' do
          expect(game_diagonal_three.check_diagonal_streak_up(row, column, symbol)).to eq(3)
        end
      end
    end
  end

  describe '#check_diagonal_streak_down' do
    context 'when there are four ♦ going down diagonaly' do
      subject(:game_diagonal_four) { described_class.new }
      let(:symbol) { '♦' }

      before do
        game_diagonal_four.board[2][0] = '♦'
        game_diagonal_four.board[3][1] = '♦'
        game_diagonal_four.board[4][2] = '♦'
        game_diagonal_four.board[5][3] = '♦'
      end

      context 'and called from the beginning' do
        let(:row) { 2 }
        let(:column) { 0 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_down(row, column, symbol)).to eq(4)
        end
      end

      context 'and called form the middle' do
        let(:row) { 3 }
        let(:column) { 1 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_down(row, column, symbol)).to eq(4)
        end
      end

      context 'and called from the end' do
        let(:row) { 5 }
        let(:column) { 3 }

        it 'returns 4' do
          expect(game_diagonal_four.check_diagonal_streak_down(row, column, symbol)).to eq(4)
        end
      end
    end

    context 'where there are three ♦ and one ♢ at the end' do
      subject(:game_diagonal_three) { described_class.new }
      let(:symbol) { '♦' }
      let(:row) { 2 }
      let(:column) { 0 }
      before do
        game_diagonal_three.board[2][0] = '♦'
        game_diagonal_three.board[3][1] = '♦'
        game_diagonal_three.board[4][2] = '♦'
        game_diagonal_three.board[5][3] = '♢'
      end

      it 'returns 3' do
        expect(game_diagonal_three.check_diagonal_streak_down(row, column, symbol)).to eq(3)
      end
    end
  end

  describe '#four_in_row?' do
    # The game_over conditions are the following
    # - at least one four in a row
    # - the board is full and the game is a tie
    context 'when there is at least one streak of 4 or more' do
      subject(:game_over) { described_class.new }
      let(:symbol) { '♦' }
      # Row and column are not important here as those two parameters are meant to be used with the previous streak methods
      let(:dummy_row) { 0 }
      let(:dummy_column) { 0 }

      before do
        allow(game_over).to receive(:check_diagonal_streak_down).and_return(4)
        allow(game_over).to receive(:check_diagonal_streak_up).and_return(1)
        allow(game_over).to receive(:check_horizontal_streak).and_return(3)
        allow(game_over).to receive(:check_vertical_streak).and_return(2)
      end

      it 'returns true' do
        expect(game_over.four_in_row?(dummy_row, dummy_column, symbol)).to be true
      end
    end

    context 'when there are no streaks of 4 or more' do
      subject(:game_over) { described_class.new }
      let(:symbol) { '♦' }
      # Row and column are not important here as those two parameters are meant to be used with the previous streak methods
      let(:dummy_row) { 0 }
      let(:dummy_column) { 0 }

      before do
        allow(game_over).to receive(:check_diagonal_streak_down).and_return(1)
        allow(game_over).to receive(:check_diagonal_streak_up).and_return(1)
        allow(game_over).to receive(:check_horizontal_streak).and_return(3)
        allow(game_over).to receive(:check_vertical_streak).and_return(2)
      end
      it 'returns false' do
        expect(game_over.four_in_row?(dummy_row, dummy_column, symbol)).to be false
      end
    end
  end
end