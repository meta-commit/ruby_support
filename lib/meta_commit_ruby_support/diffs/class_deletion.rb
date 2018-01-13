module MetaCommit::Extension::RubySupport::Diffs
  class ClassDeletion < Diff
    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION &&
          contextual_ast_has_target_node(old_ast_path) &&
          (old_ast_path.target_node.is_class? || is_name_of_class?(old_ast_path))
    end

    def string_representation
      if @old_ast_path.target_node.is_class?
        if is_in_context_of_module?(@old_ast_path)
          return "removed class #{old_ast_path.target_node.class_name} from module #{name_of_context_module(old_ast_path)}"
        end
        return "removed class #{old_ast_path.target_node.class_name}"
      end
      "removed class #{name_of_context_class(old_ast_path)}"
    end
  end
end