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

  s1 = <<EOF
b_detail_plan_default

[OBJECT:BODY_DETAIL_PLAN]

[BODY_DETAIL_PLAN:STANDARD_MATERIALS]
	This command is just a shortcut for the similar lines (USE_MATERIAL_TEMPLATE|<token>|<template>) in a creature definition.
	[ADD_MATERIAL:SKIN:SKIN_TEMPLATE]
	[ADD_MATERIAL:FAT:FAT_TEMPLATE]
	[ADD_MATERIAL:MUSCLE:MUSCLE_TEMPLATE]
	[ADD_MATERIAL:BONE:BONE_TEMPLATE]
	[ADD_MATERIAL:CARTILAGE:CARTILAGE_TEMPLATE]
	[ADD_MATERIAL:HAIR:HAIR_TEMPLATE]
	[ADD_MATERIAL:TOOTH:TOOTH_TEMPLATE]
	[ADD_MATERIAL:EYE:EYE_TEMPLATE]
	[ADD_MATERIAL:NERVE:NERVE_TEMPLATE]
	[ADD_MATERIAL:BRAIN:BRAIN_TEMPLATE]
	[ADD_MATERIAL:LUNG:LUNG_TEMPLATE]
	[ADD_MATERIAL:HEART:HEART_TEMPLATE]
	[ADD_MATERIAL:LIVER:LIVER_TEMPLATE]
	[ADD_MATERIAL:GUT:GUT_TEMPLATE]
	[ADD_MATERIAL:STOMACH:STOMACH_TEMPLATE]
	[ADD_MATERIAL:GIZZARD:GIZZARD_TEMPLATE]
	[ADD_MATERIAL:PANCREAS:PANCREAS_TEMPLATE]
	[ADD_MATERIAL:SPLEEN:SPLEEN_TEMPLATE]
	[ADD_MATERIAL:KIDNEY:KIDNEY_TEMPLATE]
	[ADD_MATERIAL:LEATHER:LEATHER_TEMPLATE]
	[ADD_MATERIAL:TALLOW:TALLOW_TEMPLATE]
	[ADD_MATERIAL:SOAP:SOAP_TEMPLATE]
EOF

  parser = Armok::Parser.new
  o = parser.parse(s)
  o1 = parser.parse(s1)

  it 'gets embedded filename' do
    expect(o.name).to eq('item_armor')
  end

  it 'gets object type' do
    expect(o.type).to eq('ITEM')
  end

  it 'gets definitions list' do
    expect(o.definitions.length).to eq(2)
    expect(o1.definitions.length).to eq(1)
  end

  it 'gets tokens' do
    expect(o.definitions[0].tokens[0].to_s).to eq('NAME:breastplate:breastplates')
  end

  it 'gets tokens with multiple values' do
    expect(o.definitions[0].tokens[0].values.length).to eq(2)
  end

  it 'ignores comments' do
    expect(o1.definitions[0].tokens[1].to_s).to eq('ADD_MATERIAL:FAT:FAT_TEMPLATE')
  end

  it 'strips invalid UTF-8 bytes' do
    invalid = "hello_world\n\n[OBJECT:hello]\n\n[SOME\255:VALUE]\n[K:V]".force_encoding('UTF-8')
    valid = "hello_world\n\n[OBJECT:hello]\n\n[SOME:VALUE]\n[K:V]".force_encoding('UTF-8')
    expect(parser.parse(invalid)).to eq(valid)
  end

end
