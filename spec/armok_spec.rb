require 'spec_helper'

describe Armok do

  it 'has a version number' do
    expect(Armok::VERSION).not_to be nil
  end

end

describe Armok::Parser do
  s = <<EOF
item_armor

[OBJECT:ITEM]

[ITEM_ARMOR:ITEM_ARMOR_BREASTPLATE]
[NAME:breastplate:breastplates]
[ARMORLEVEL:3]
[UBSTEP:0]
[LBSTEP:0]
[SHAPED]
[LAYER:ARMOR]
[COVERAGE:100]
[LAYER_SIZE:20]
[LAYER_PERMIT:50]
[MATERIAL_SIZE:9]
[HARD]
[METAL]

[ITEM_ARMOR:ITEM_ARMOR_MAIL_SHIRT]
[NAME:mail shirt:mail shirts]
[ARMORLEVEL:2]
[UBSTEP:1]
[LBSTEP:1]
[LAYER:OVER]
[COVERAGE:100]
[LAYER_SIZE:15]
[LAYER_PERMIT:50]
[MATERIAL_SIZE:6]
[HARD]
[METAL]
[STRUCTURAL_ELASTICITY_CHAIN_ALL]
EOF

  p = Armok::Parser.new(s)

  it 'parses embedded filename' do
    expect(p.name).to eq('item_armor')
  end

  it 'parses object type' do
    expect(p.type).to eq('ITEM')
  end

  it 'parses definitions' do
    expect(p.definitions.length).to eq(2)
  end

  it 'parses attributes' do
    expect(p.definitions[0].attributes[0].to_s).to eq('NAME:breastplate:breastplates')
  end

  it 'parses attributes with multiple values' do
    expect(p.definitions[0].attributes[0].values.length).to eq(2)
  end

  it 'recreates input' do
    expect(p.to_s).to eq(s)
  end

end
