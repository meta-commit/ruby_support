module MetaCommit::Extension::RubySupport::Diffs
  class InitializeChanged < Diff
    INITIALIZE_METHOD_NAME = 'initialize'

    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE &&
          contextual_ast_has_target_node(old_ast_path) &&
          contextual_ast_has_target_node(new_ast_path) &&
          is_in_context_of_method?(old_ast_path) &&
          is_in_context_of_method?(new_ast_path) &&
          name_of_context_method(old_ast_path) == INITIALIZE_METHOD_NAME && name_of_context_method(new_ast_path) == INITIALIZE_METHOD_NAME
    end

    def string_representation
      "change initialization of #{path_to_component(new_ast_path, 0)}"
    end
  end
end