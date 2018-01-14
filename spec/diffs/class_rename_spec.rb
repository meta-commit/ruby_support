require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::ClassRename do
  let(:type) { MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE }
  let(:old_file_name) { 'old_file_name' }
  let(:new_file_name) { 'new_file_name' }

  describe '#supports_change' do
    it 'supports replace where both ast are class definition' do
      old_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_ast_path = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)

      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      new_ast_path = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)
      expect(subject.supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when both ast are module definition' do
      old_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_and_method'))
      old_ast_path = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)

      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(file_fixture('module_with_class_new_and_method'))
      new_ast_path = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)

      subject.diff_type=type
      subject.commit_old=nil
      subject.commit_new=nil
      subject.old_file=old_file_name
      subject.new_file=new_file_name
      subject.old_lineno=2
      subject.new_lineno=2
      subject.old_ast_path=old_ast_path
      subject.new_ast_path=new_ast_path

      expect(subject.string_representation).to eq('rename class TestClass to TestClassNEW')
    end
  end
end