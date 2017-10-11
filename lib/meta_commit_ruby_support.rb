require "meta_commit_ruby_support/version"

module MetaCommit
  module Extension
    module RubySupport
    end
  end
end

require "meta_commit_contracts"
# parsers
require "meta_commit_ruby_support/parsers/ruby"
# diffs
require "meta_commit_ruby_support/diffs/diff"
require "meta_commit_ruby_support/diffs/class_creation"
require "meta_commit_ruby_support/diffs/class_deletion"
require "meta_commit_ruby_support/diffs/class_rename"
require "meta_commit_ruby_support/diffs/method_creation"
require "meta_commit_ruby_support/diffs/method_deletion"
require "meta_commit_ruby_support/diffs/changes_in_method"
require "meta_commit_ruby_support/diffs/module_creation"
require "meta_commit_ruby_support/diffs/module_deletion"
require "meta_commit_ruby_support/diffs/module_rename"
require "meta_commit_ruby_support/diffs/initialize_changed"
# models
require "meta_commit_ruby_support/models/ast"

require "meta_commit_ruby_support/locator"