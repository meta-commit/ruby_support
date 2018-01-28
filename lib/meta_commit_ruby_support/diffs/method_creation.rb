module MetaCommit::Extension::RubySupport::Diffs
  class MethodCreation < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_ADDITION &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          (context.new_contextual_ast.target_node.is_method? || is_in_context_of_method?(context.new_contextual_ast))
    end

    def string_representation
      if change_context.new_contextual_ast.target_node.is_method?
        if is_in_context_of_module?(change_context.new_contextual_ast)
          if is_in_context_of_class?(change_context.new_contextual_ast)
            return "create #{name_of_context_module(change_context.new_contextual_ast)}::#{name_of_context_class(change_context.new_contextual_ast)}##{change_context.new_contextual_ast.target_node.method_name}"
          end
          return "create #{name_of_context_module(change_context.new_contextual_ast)}##{change_context.new_contextual_ast.target_node.method_name}"
        end
        if is_in_context_of_class?(change_context.new_contextual_ast)
          return "create #{name_of_context_class(change_context.new_contextual_ast)}##{change_context.new_contextual_ast.target_node.method_name}"
        end
      end
      "changes in method #{name_of_context_method(change_context.new_contextual_ast)}"
    end
  end
end