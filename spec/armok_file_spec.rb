require 'spec_helper'

describe Armok::File do
  before do
    @file = Armok::File.read(
      File.join(Dir.pwd, 'spec', 'fixtures', 'creature_standard.txt')
    )
  end

  describe '#read' do
    it 'reads raw files' do
      expect(@file).to be_a(Armok::File)
    end

    it 'gets embedded filename' do
      expect(@file.key).to eq('creature_standard')
    end

    it 'gets object type' do
      expect(@file.type).to eq('CREATURE')
    end

    it 'gets entities' do
      expect(@file.items).to be_an(Armok::Entities)
    end
  end

  describe '#strip_invalid_utf8_bytes!' do
    it 'strips invalid UTF-8 bytes' do
      expect(@file.strip_invalid_utf8_bytes!("VA\255LID")).to eq('VALID')
    end
  end
end
