require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Models::Ast do
  describe '#ast' do
    it 'returns passed ast' do
      mock = double(:ast)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.ast).to be mock
    end
  end
  describe '#children' do
    it 'returns array with children nodes of passed ast' do
      mock = double(:ast, :children => [double(:child1), double(:child2),])

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.children).to be_an_instance_of(Array)
      expect(ast.children).to all(be_a(MetaCommit::Contracts::Ast))
      expect(ast.children.length).to be 2
    end
    it 'returns empty array for symbol array' do
      code = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(':element')

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(code)

      expect(ast.children.first.children).to be_an_instance_of(Array)
      expect(ast.children.first.children.size).to eq(0)
    end
  end
  describe '#first_line' do
    it 'returns first line number of ast location' do
      mock = double(:ast, :location => double(:first_line => 42))

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.first_line).to be 42
    end
    it 'returns nil when ast does not have location' do
      mock = double(:ast)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.first_line).to be nil
    end
    it 'returns nil when ast is Parser::Source::Map::Collection' do
      mock = class_double(Parser::Source::Map::Collection)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.first_line).to be nil
    end
  end
  describe '#last_line' do
    it 'returns last line number of ast location' do
      mock = double(:ast, :location => double(:last_line => 42))

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.last_line).to be 42
    end
    it 'returns nil when ast does not have location' do
      mock = double(:ast)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.last_line).to be nil
    end
    it 'returns nil when ast is Parser::Source::Map::Collection' do
      mock = class_double(Parser::Source::Map::Collection)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(mock)

      expect(ast.last_line).to be nil
    end
  end
  describe '#classes' do
    it 'returns classes inside module' do
      source_code=<<-EOT
module FooModule
  @@variable1
  @@variable2

  class FooClass
  end
  class BarClass
  end
  class BazClass
  end
end
      EOT
      parsed=Parser::CurrentRuby.parse(source_code)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(parsed)

      classes=ast.classes
      class_names=classes.map {|class_ast| class_ast.class_name}

      expect(classes.length).to be(3)
      expect(class_names).to be == %w(FooClass BarClass BazClass)
    end
    it 'returns classes extracted from nested modules' do
      source_code=<<-EOT
module FooModule
  @@variable1
  @@variable2

  module BarModule
    class FooClass
    end
    class BarClass
    end
    class BazClass
    end
  end
end
      EOT
      parsed=Parser::CurrentRuby.parse(source_code)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(parsed)

      classes=ast.classes
      class_names=classes.map {|class_ast| class_ast.class_name}

      expect(classes.length).to be(3)
      expect(class_names).to be == %w(FooClass BarClass BazClass)
    end
    it 'returns empty array when element does not have classes' do
      source_code=<<-EOT
module FooModule
  @@variable1
  @@variable2

  def FooMethod
  end
  def BarMethod
  end
  def BazMethod
  end
end
      EOT
      parsed=Parser::CurrentRuby.parse(source_code)

      ast = MetaCommit::Extension::RubySupport::Models::Ast.new(parsed)

      classes=ast.classes

      expect(classes.length).to be(0)
    end
  end
end