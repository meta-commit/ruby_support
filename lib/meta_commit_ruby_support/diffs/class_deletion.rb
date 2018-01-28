module MetaCommit::Extension::RubySupport::Diffs
  class ClassDeletion < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          (context.old_contextual_ast.target_node.is_class? || is_name_of_class?(context.old_contextual_ast))
    end

    def string_representation
      if change_context.old_contextual_ast.target_node.is_class?
        if is_in_context_of_module?(change_context.old_contextual_ast)
          return "remove class #{change_context.old_contextual_ast.target_node.class_name} from module #{name_of_context_module(change_context.old_contextual_ast)}"
        end
        return "remove class #{change_context.old_contextual_ast.target_node.class_name}"
      end
      "remove class #{name_of_context_class(change_context.old_contextual_ast)}"
    end
  end
end