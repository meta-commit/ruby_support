require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::ClassDeletion do
  let(:type) { MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION }
  let(:old_file_name) { 'old_file_name' }
  let(:new_file_name) { 'new_file_name' }
  let(:new_contextual_ast) { MetaCommit::Contracts::ContextualAst.new }

  describe '#supports_change' do
    it 'supports deletion where ast is class definition' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be true
    end
    it 'supports deletion where ast is end of class definition' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.supports_change(change_context)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when is class in context of module' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('remove class TestClass from module TestModule')
    end
    it 'prints change when is class' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('remove class TestClass')
    end
    it 'prints change when class name has name from multiple parts' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('inherited_class'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path_with_whole_file_change(source_ast)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 1
      change_context.new_lineno = -1
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('remove class TestClass')
    end
  end
end