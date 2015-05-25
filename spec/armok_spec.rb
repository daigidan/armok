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
#  o1 = parser.parse(s1)

  it 'parses embedded filename' do
    expect(o.name).to eq('item_armor')
  end

  it 'parses object type' do
    expect(o.type).to eq('ITEM')
  end

  it 'parses definitions' do
    expect(o.definitions.length).to eq(2)
  end

  it 'parses attributes' do
    expect(o.definitions[0].attributes[0].to_s).to eq('NAME:breastplate:breastplates')
  end

  it 'parses attributes with multiple values' do
    expect(o.definitions[0].attributes[0].values.length).to eq(2)
  end

  it 'recreates input' do
    expect(o.to_s).to eq(s)
  end

#  it 'parses definitions with comments' do
#    expect(p1.to_s).to eq(s1)
#  end

end
