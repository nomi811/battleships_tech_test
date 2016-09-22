require 'grid'
require 'cell'
require 'ship'

describe Grid do

  let(:grid) { Grid.new('Sally') }
  let(:cell) { Cell.new("A1") }
  let(:destroyer) { Ship.patrol_boat }
  let(:cruiser) { Ship.destroyer }

  context 'Grid layout' do
    it 'has 100 cells' do
      expect(grid.create_cells.count).to eq 100
    end
  end

  context 'Vertical placement' do
    before do
      grid.place(destroyer, 'A1', 'vertically')
    end

    it 'can assign the ships to first cell vertically' do
      expect(grid.cells['A1'].content).to eq destroyer
    end

    it 'can assign the ships to other cells vertically' do
      expect(grid.cells['A2'].content).to eq destroyer
    end

    it 'can assign the ships to cells vertically and leave the rest of the grid unchanged' do
      grid.cells.reject { |key, cell| key == 'A1' or key == 'A2' }.each { |key, cell| expect(cell.content).to eq 'water' }
    end
  end

  context 'Horizontal placement' do
    before do
      grid.place(destroyer, 'A1', 'horizontally')
    end

    it 'can assign the ships to the first cell horizontally' do
      expect(grid.cells['A1'].content).to eq destroyer
    end

    it 'can assign the ships to other cells horizontally' do
      expect(grid.cells['B1'].content).to eq destroyer
    end

    it 'can assign the ships to cells horizontally and leave the rest of the grid unchanged' do
      grid.cells.reject { |key, cell| key == 'A1' or key == 'B1' }.each { |key, cell| expect(cell.content).to eq 'water' }
    end

    xit 'returns an error if there is already a ship where user wants to place a ship vertically' do
      grid.place(cruiser, 'A1', 'horizontally')
      expect(lambda{ grid.place(destroyer, 'B1', 'vertically')}).to raise_error(RuntimeError, 'There is a ship there already')
    end

    xit 'returns an error if there is already a ship where the user wants to place another ship horizontally' do
      grid.place(cruiser, 'B1', 'vertically')
      expect(lambda{ grid.place(destroyer, 'A1', 'horizontally')}).to raise_error('There is a ship there already')
    end

    it 'returns miss when water is hit' do
      grid.hit('A1')
      expect(grid.cells['A1'].status).to eq 'miss'
    end
  end
end
