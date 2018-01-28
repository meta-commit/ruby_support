module MetaCommit::Extension::RubySupport::Diffs
  class MethodDeletion < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          (context.old_contextual_ast.target_node.is_method? || is_in_context_of_method?(context.old_contextual_ast))
    end

    def string_representation
      if change_context.old_contextual_ast.target_node.is_method?
        if is_in_context_of_module?(change_context.old_contextual_ast)
          if is_in_context_of_class?(change_context.old_contextual_ast)
            return "remove #{name_of_context_module(change_context.old_contextual_ast)}::#{name_of_context_class(change_context.old_contextual_ast)}##{change_context.old_contextual_ast.target_node.method_name}"
          end
          return "remove method #{change_context.old_contextual_ast.target_node.method_name} from module #{name_of_context_module(change_context.old_contextual_ast)}"
        end
        if is_in_context_of_class?(change_context.old_contextual_ast)
          return "remove #{name_of_context_class(change_context.old_contextual_ast)}##{change_context.old_contextual_ast.target_node.method_name}"
        end
      end
      "changes in method #{name_of_context_method(change_context.old_contextual_ast)}"
    end
  end
end