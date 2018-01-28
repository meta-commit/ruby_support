require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::ChangesInMethod do
  let(:type) { MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE }
  let(:old_file_name) { 'old_file_name' }
  let(:new_file_name) { 'new_file_name' }

  describe '#supports_change' do
    it 'supports replace where both ast are in context of method' do
      old_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_new_and_method_with_body'))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 4)

      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_new_and_method_with_body'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when new ast is in context of class' do
      old_contextual_ast = nil

      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_new_and_method_with_body'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 5
      change_context.new_lineno=5
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('changes in TestClassNEW#test_method')
    end
    it 'prints change when when changes in method' do
      old_contextual_ast = nil

      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('method_with_body'))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = type
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 5
      change_context.new_lineno = 5
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('changes in #test_method')
    end
  end
end