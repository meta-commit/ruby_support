require 'spec_helper'

describe MetaCommit::Extension::RubySupport::Diffs::ModuleRename do
  let(:type) { MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE }
  let(:old_file_name) { 'old_file_name' }
  let(:new_file_name) { 'new_file_name' }

  describe '#supports_change' do
    it 'supports replace where both ast are module definition' do
      old_ast_content = <<-eos
module TestModule
  class TestClass
    def test_method
    end
  end
end
      eos
      old_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(old_ast_content)
      old_ast_path = ContextualNodeCreator.new.create_ast_path(old_source_ast, 1)

      new_ast_content = <<-eos
module TestModule
  class TestClass
    def test_method
    end
  end
end
      eos
      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(new_ast_content)
      new_ast_path = ContextualNodeCreator.new.create_ast_path(new_source_ast, 1)
      expect(subject.supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)).to be true
    end
  end

  describe '#string_representation' do
    it 'prints change when both ast are module definition' do
      old_ast_content = <<-eos
module TestModule
  class TestClass
    def test_method
    end
  end
end
      eos
      old_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(old_ast_content)
      old_ast_path = ContextualNodeCreator.new.create_ast_path(old_source_ast, 1)

      new_ast_content = <<-eos
module TestModuleNEW
  class TestClass
    def test_method
    end
  end
end
      eos
      new_source_ast = MetaCommit::Extension::RubySupport::Parsers::Ruby.new.parse(new_ast_content)
      new_ast_path = ContextualNodeCreator.new.create_ast_path(new_source_ast, 1)

      subject.diff_type=type
      subject.commit_old=nil
      subject.commit_new=nil
      subject.old_file=old_file_name
      subject.new_file=new_file_name
      subject.old_lineno=1
      subject.new_lineno=1
      subject.old_ast_path=old_ast_path
      subject.new_ast_path=new_ast_path

      expect(subject.string_representation).to eq('rename module TestModule to TestModuleNEW')
    end
  end
end