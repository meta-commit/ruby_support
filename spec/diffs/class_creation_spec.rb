require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::ClassCreation do
  let(:type) {MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_ADDITION}
  let(:old_file_name) {'old_file_name'}
  let(:new_file_name) {'new_file_name'}
  let(:old_contextual_ast) {nil}

  describe '#supports_change' do
    it 'supports addition where ast is class definition' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be true
    end
    it 'supports addition where ast is end of class definition' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when is class in context of module' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

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

      expect(subject.string_representation).to eq('create TestModule::TestClass')
    end
    it 'prints change when is class' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

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

      expect(subject.string_representation).to eq('create TestModule::TestClass')
    end
    it 'prints change when is class name in context of module' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 2)

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

      expect(subject.string_representation).to eq('create TestModule::TestClass')
    end
    it 'prints change when is class name' do
      source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('test_class'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(source_ast, 1)

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

      expect(subject.string_representation).to eq('create class TestClass')
    end
  end
end