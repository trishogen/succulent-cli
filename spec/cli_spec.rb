describe 'SucculentCli::CLI' do
  let(:succulent_cli) { SucculentCli::CLI.new }
  let(:succulent_cli_bigger_display) { SucculentCli::CLI.new(30) }

  describe '::new' do
    it 'sets an instance variable @display_size on initialization to twenty' do
      expect(succulent_cli.instance_variable_get(:@display_size)).to eq(20)
    end

    it 'optionally takes a display size on initialization' do
      expect(succulent_cli_bigger_display.instance_variable_get(:@display_size)).to eq(30)
    end
  end

  describe '#increase_page' do
    before do
      succulent_cli.instance_variable_set(:@total_pages, 6)
    end

    context 'when the display page is below the total pages' do
      it 'increases the display page by one' do
        succulent_cli.increase_page
        expect(succulent_cli.instance_variable_get(:@display_page)).to eq(2)
      end
    end

    context 'when the display page is at the max' do
      it 'sets the display page to the first page' do
        succulent_cli.instance_variable_set(:@display_page, 6)
        succulent_cli.increase_page
        expect(succulent_cli.instance_variable_get(:@display_page)).to eq(1)
      end
    end
  end


  describe '#decrease_page' do
    before do
      succulent_cli.instance_variable_set(:@total_pages, 6)
    end

    context 'when past the first page' do
      it 'decreases the display page by one' do
        succulent_cli.instance_variable_set(:@display_page, 2)
        succulent_cli.decrease_page
        expect(succulent_cli.instance_variable_get(:@display_page)).to eq(1)
      end
    end

    context 'when on the first page' do
      it 'sets the display page to the last page' do
        succulent_cli.instance_variable_set(:@display_page, 1)
        succulent_cli.decrease_page
        expect(succulent_cli.instance_variable_get(:@display_page)).to eq(6)
      end
    end
  end
end
