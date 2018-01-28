require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::MethodDeletion do
  let(:type) { MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION }
  let(:old_file_name) { 'old_file_name' }
  let(:new_file_name) { 'new_file_name' }
  let(:new_contextual_ast) { nil }

  describe '#supports_change' do
    it 'supports addition where ast is method definition' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = nil

      expect(subject.supports_change(change_context)).to be true
    end
    it 'supports addition where ast is in context of method' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 4)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = nil

      expect(subject.supports_change(change_context)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when is method in context of module and class' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
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


      expect(subject.string_representation).to eq('remove TestModule::TestClass#test_method')
    end
    it 'prints change when method is in context of module' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_method'))
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

      expect(subject.string_representation).to eq('remove method test_method from module TestModule')
    end
    it 'prints change when method is in context of class' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('class_with_method'))
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

      expect(subject.string_representation).to eq('remove TestClass#test_method')
    end
  end
end