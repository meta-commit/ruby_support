module MetaCommit::Extension::RubySupport::Diffs
  class MethodDeletion < Diff
    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION &&
          contextual_ast_has_target_node(old_ast_path) &&
          (old_ast_path.target_node.is_method? || is_in_context_of_method?(old_ast_path))
    end

    def string_representation
      if @old_ast_path.target_node.is_method?
        if is_in_context_of_module?(@old_ast_path)
          if is_in_context_of_class?(@old_ast_path)
            return "remove #{name_of_context_module(old_ast_path)}::#{name_of_context_class(old_ast_path)}##{old_ast_path.target_node.method_name}"
          end
          return "remove method #{old_ast_path.target_node.method_name} from module #{name_of_context_module(old_ast_path)}"
        end
        if is_in_context_of_class?(@old_ast_path)
          return "remove #{name_of_context_class(old_ast_path)}##{old_ast_path.target_node.method_name}"
        end
      end
      "changes in method #{name_of_context_method(old_ast_path)}"
    end
  end
end