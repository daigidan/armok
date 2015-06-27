##
# Armok: God of Blood
#
# @category Fun
# @package Armok
# @copyright Copyright (c) 2015 daigidan@gmail.com
# @license http://opensource.org/licenses/MIT
#
##
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'armok'

Gem::Specification.new do |spec|
  spec.name        = 'armok'
  spec.version     = Armok::VERSION
  spec.author      = 'Sean Evans'
  spec.email       = 'daigidan@gmail.com'
  spec.summary     = 'A small library for working with the raw files of Dwarf Fortress.'
  spec.description = <<-EOF
    Armok commands and creation is shaped!
    This library parses and modifies Dwarf Fortress' raw files for modding purposes.
  EOF
  spec.homepage      = 'https://github.com/daigidan/armok'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.bindir        = 'bin'
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
end
