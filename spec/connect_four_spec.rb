# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#create_board' do
    subject(:game_board) { described_class.new }

    it 'creates 6 rows' do
      rows = game_board.create_board.length
      expect(rows).to eql(6)
    end

    it 'creates 7 columns' do
      row = game_board.create_board[0]
      columns = row.length
      expect(columns).to eql(7)
    end
  end

  describe '#add_black' do
    # Three different cases where the black symbol could be added
    # 5th row indicates the bottom of the board
    # 0th row indicates the top of the board

    context 'when there is nothing at the bottom of the board' do
      subject(:game_black) { described_class.new }
      let(:column) { 5 }
      let(:row) { 5 }
      it 'symbol reaches the bottom' do
        game_black.add_black(5)
        square = game_black.board[row][column]
        expect(square).to eq('⚫')
      end
    end

    context 'when there is already a symbol occupying a square' do
      subject(:game_black) { described_class.new }
      let(:column) { 5 }
      let(:row) { 4 }
      before do
        game_black.add_black(5)
      end
      it 'the symbol falls on top of the square being occupied' do
        game_black.add_black(5)
        square = game_black.board[row][column]
        expect(square).to eq('⚫')
      end
    end
  

    context 'when there is no room left to add the symbol' do
      subject(:game_black) { described_class.new }
      before do
        # To fill up the column (assuming previous tests pass)
        6.times { game_black.add_black(5) }
      end
      it '#out_bounds_message is called' do
        expect(game_black).to receive(:out_bounds_message).once
        game_black.add_black(5)
      end
    end
  end

  describe '#add_white' do
    # Similar to the test for add_black
    context 'when there is nothing on the bottom of the board' do
      subject(:game_white) { described_class.new }
      let(:column) { 3 }
      let(:row) { 5 }
      it 'reaches the bottom' do
        game_white.add_white(3)
        square = game_white.board[row][column]
        expect(square).to eq('⚪')
      end
    end

    context 'when there is already a symbol occupying a square' do
      subject(:game_white) { described_class.new }
      let(:column) { 3 }
      let(:row) { 4 }
      before do
        game_white.add_white(3)
      end

      it 'symbol falls on top of the square being occupied' do
        game_white.add_white(3)
        square = game_white.board[row][column]
        expect(square).to eq('⚪')
      end
    end

    context 'when there is no room left to add the symbol' do
      subject(:game_white) { described_class.new }
      before do
        # To fill up the column (assuming previous tests pass)
        6.times { game_white.add_white(3) }
      end

      it '#out_of_bounds message is called' do
        expect(game_white).to receive(:out_bounds_message).once
        game_white.add_white(3)
      end
    end
  end
end
