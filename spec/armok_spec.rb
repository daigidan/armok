require 'spec_helper'

describe Armok do

  it 'has a version number' do
    expect(Armok::VERSION).not_to be nil
  end

end

describe Armok::File do
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

  s2 = <<EOF
inorganic_stone_mineral

[OBJECT:INORGANIC]

Uristocrat: Density values from the research thread:
http://www.bay12forums.com/smf/index.php?topic=80022.0


[INORGANIC:HEMATITE]
[USE_MATERIAL_TEMPLATE:STONE_TEMPLATE]
[STATE_NAME_ADJ:ALL_SOLID:hematite][DISPLAY_COLOR:4:7:0][TILE:139]
[ENVIRONMENT:SEDIMENTARY:VEIN:100]
[ENVIRONMENT:IGNEOUS_EXTRUSIVE:VEIN:100]
[ITEM_SYMBOL:'*']
[METAL_ORE:IRON:100]
[SOLID_DENSITY:5260]
[MATERIAL_VALUE:8]
[IS_STONE]
[MELTING_POINT:12736]

ore of mercury, powdered gives vermilion dye
[INORGANIC:CINNABAR]
[USE_MATERIAL_TEMPLATE:STONE_TEMPLATE]
[STATE_NAME_ADJ:ALL_SOLID:cinnabar][DISPLAY_COLOR:4:7:1][TILE:131]
[ENVIRONMENT:IGNEOUS_EXTRUSIVE:VEIN:100]
[ENVIRONMENT_SPEC:SHALE:VEIN:100]
[ENVIRONMENT_SPEC:QUARTZITE:VEIN:100]
[ITEM_SYMBOL:'*']
[IS_STONE]
[MELTING_POINT:11044]
[SOLID_DENSITY:8100]

to actually get chromium, have to heat 'in the presence of aluminum or silicon'
    might use in stainless steel making, but not sure how that should work
[INORGANIC:CHROMITE]
[USE_MATERIAL_TEMPLATE:STONE_TEMPLATE]
[STATE_NAME_ADJ:ALL_SOLID:chromite][DISPLAY_COLOR:0:7:1][TILE:132]
[ENVIRONMENT_SPEC:OLIVINE:VEIN:100]
[SOLID_DENSITY:4795]   Former value was far too low.
[IS_STONE]
[MELTING_POINT:13645]
EOF

  s3 = <<EOF
language_words

[OBJECT:LANGUAGE]

[WORD:ABBEY]
    [NOUN:abbey:abbeys]
        [FRONT_COMPOUND_NOUN_SING]
        [REAR_COMPOUND_NOUN_SING]
        [THE_NOUN_SING]
        [REAR_COMPOUND_NOUN_PLUR]
        [OF_NOUN_PLUR]

[WORD:MIDNIGHT]
    [NOUN:midnight:midnights]
        [THE_COMPOUND_NOUN_SING]
        [THE_NOUN_SING]
        [OF_NOUN_SING]
        [OF_NOUN_PLUR]

[WORD:MIGHTY]
    [NOUN:might:mights]
    [ADJ:mighty]
        [ADJ_DIST:2]
        [FRONT_COMPOUND_ADJ]
        [REAR_COMPOUND_ADJ]
        [THE_COMPOUND_ADJ]

[WORD:MIGHTINESS]

[WORD:MILE]
    [NOUN:mile:miles]
        [FRONT_COMPOUND_NOUN_SING]
        [REAR_COMPOUND_NOUN_SING]
        [THE_COMPOUND_NOUN_SING]
        [THE_NOUN_SING]
        [REAR_COMPOUND_NOUN_PLUR]
        [THE_COMPOUND_NOUN_PLUR]
        [OF_NOUN_PLUR]

[WORD:MINCE]
    [VERB:mince:minces:minced:minced:mincing]
        [STANDARD_VERB]

[WORD:TARNISH]
    [NOUN:tarnish:]
        [FRONT_COMPOUND_NOUN_SING]
        [REAR_COMPOUND_NOUN_SING]
        [THE_NOUN_SING]
        [OF_NOUN_SING]
    [VERB:tarnish:tarnishes:tarnished:tarnished:tarnishing]
        [STANDARD_VERB]

EOF

  p = Armok::File.new
  o = p.parse(s)
  o1 = p.parse(s1)
  o2 = p.parse(s2)
  o3 = p.parse(s3)

  it 'gets embedded filename' do
    expect(o.name).to eq('item_armor')
  end

  it 'gets object type' do
    expect(o.type).to eq('ITEM')
  end

  it 'gets entities' do
    expect(o.items).to be_an(Armok::Entities)
    expect(o.empty?).to eq(false)
    expect(o.length).to eq(2)
    expect(o1.items).to be_an(Armok::Entities)
    expect(o1.empty?).to eq(false)
    expect(o1.length).to eq(1)
  end

  it 'gets entity' do
    expect(o[0].id).to eq('ITEM_ARMOR_BREASTPLATE')
  end

  it 'gets tokens' do
    expect(o[0].items).to be_an(Array)
  end

  it 'gets token key and values' do
    expect(o[0].items[0].key).to eq('NAME')
    expect(o[0].items[0].values[0]).to eq('breastplate')
  end

  it 'gets tokens with multiple values' do
    expect(o[0].items[0].values.length).to eq(2)
  end

  it 'ignores comments' do
    expect(o1.length).to eq(1)
    expect(o2.length).to eq(3)
  end

  it 'strips invalid UTF-8 bytes' do
    invalid = "hello_world\n\n[OBJECT:hello]\n\n[SOME\255:VALUE]\n[K:V]".force_encoding('UTF-8')
    valid = "hello_world\n\n[OBJECT:hello]\n\n[SOME:VALUE]\n[K:V]".force_encoding('UTF-8')
    expect(p.parse(invalid).to_s).to eq(valid)
  end

  it 'parses definitions with no tokens' do
    expect(o3.length).to eq(7)
  end
end
