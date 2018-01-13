module MetaCommit::Extension::RubySupport::Diffs
  class MethodCreation < Diff
    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_ADDITION &&
          contextual_ast_has_target_node(new_ast_path) &&
          (new_ast_path.target_node.is_method? || is_in_context_of_method?(new_ast_path))
    end

    def string_representation
      if @new_ast_path.target_node.is_method?
        if is_in_context_of_module?(@new_ast_path)
          if is_in_context_of_class?(@new_ast_path)
            return "created #{name_of_context_module(new_ast_path)}::#{name_of_context_class(new_ast_path)}##{new_ast_path.target_node.method_name}"
          end
          return "created #{name_of_context_module(new_ast_path)}##{new_ast_path.target_node.method_name}"
        end
        if is_in_context_of_class?(@new_ast_path)
          return "created #{name_of_context_class(new_ast_path)}##{new_ast_path.target_node.method_name}"
        end
      end
      "changes in method #{name_of_context_method(new_ast_path)}"
    end
  end
end