module MetaCommit::Extension::RubySupport
  # Package interface
  class Locator < MetaCommit::Contracts::Locator
    # @return [Array] parser classes that package provides
    def parsers
      [
          MetaCommit::Extension::RubySupport::Parsers::Ruby,
      ]
    end

    # @return [Array] diff classes that package provides
    def diffs
      [
          MetaCommit::Extension::RubySupport::Diffs::InitializeChanged,
          MetaCommit::Extension::RubySupport::Diffs::ClassCreation,
          MetaCommit::Extension::RubySupport::Diffs::ClassDeletion,
          MetaCommit::Extension::RubySupport::Diffs::ClassRename,
          MetaCommit::Extension::RubySupport::Diffs::MethodCreation,
          MetaCommit::Extension::RubySupport::Diffs::MethodDeletion,
          MetaCommit::Extension::RubySupport::Diffs::ChangesInMethod,
          MetaCommit::Extension::RubySupport::Diffs::ModuleCreation,
          MetaCommit::Extension::RubySupport::Diffs::ModuleDeletion,
          MetaCommit::Extension::RubySupport::Diffs::ModuleRename,
          MetaCommit::Extension::RubySupport::Diffs::Diff,
      ]
    end
  end
end