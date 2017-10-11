module MetaCommit::Extension::RubySupport::Diffs
  class ModuleRename < Diff
    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE && !old_ast_path.target_node.empty_ast? && !new_ast_path.target_node.empty_ast? && is_name_of_module?(old_ast_path) && is_name_of_module?(new_ast_path)
    end

    def string_representation
      "renamed module #{name_of_context_module(old_ast_path)} to #{name_of_context_module(new_ast_path)}"
    end
  end
end